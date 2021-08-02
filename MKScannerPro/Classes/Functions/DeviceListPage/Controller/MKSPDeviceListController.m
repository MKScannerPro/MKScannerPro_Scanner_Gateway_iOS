//
//  MKSPDeviceListController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPDeviceListController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"

#import "MKSPAboutController.h"
#import "MKSPServerForAppController.h"
#import "MKSPScanPageController.h"

#import "MKSPDeviceModel.h"

#import "MKSPNetworkManager.h"

#import "MKSPServerManager.h"

#import "MKSPDeviceListDatabaseManager.h"

#import "MKSPAddDeviceView.h"
#import "MKSPDeviceListCell.h"
#import "MKSPEasyShowView.h"

#import "MKSPDeviceDataController.h"

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKSPDeviceListController ()<UITableViewDelegate,
UITableViewDataSource,
MKSPDeviceListCellDelegate,
MKSPDeviceModelDelegate>

/// 没有添加设备的时候显示
@property (nonatomic, strong)MKSPAddDeviceView *addView;

/// 本地有设备的时候显示
@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)UIView *footerView;

@property (nonatomic, strong)MKSPEasyShowView *loadingView;

@property (nonatomic, strong)NSMutableArray *dataList;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@end

@implementation MKSPDeviceListController

- (void)dealloc {
    NSLog(@"MKSPDeviceListController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDatabase];
    [self runloopObserver];
    [self addNotifications];
}

#pragma mark - super method
- (void)leftButtonMethod {
    MKSPServerForAppController *vc = [[MKSPServerForAppController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightButtonMethod {
    MKSPAboutController *vc = [[MKSPAboutController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKSPDeviceListCell *cell = [MKSPDeviceListCell initCellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    [cell resetFlagForFrame];
    return cell;
}

#pragma mark - MKSPDeviceListCellDelegate
/**
 删除
 
 @param index 所在index
 */
- (void)sp_cellDeleteButtonPressed:(NSInteger)index {
    if (index >= self.dataList.count) {
        return;
    }
    MKSPDeviceModel *deviceModel = self.dataList[index];
    [[MKHudManager share] showHUDWithTitle:@"Delete..." inView:self.view isPenetration:NO];
    [MKSPDeviceListDatabaseManager deleteDeviceWithDeviceID:deviceModel.deviceID sucBlock:^{
        [[MKHudManager share] hide];
        [self.dataList removeObject:deviceModel];
        [[MKSPServerManager shared] unsubscriptions:@[[deviceModel currentPublishedTopic]]];
        [self loadMainViews];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

/**
 重新设置cell的子控件位置，主要是删除按钮方面的处理
 */
- (void)sp_cellResetFrame {
    [self cellCanSelected];
}

/// cell的点击事件，用来重置cell的布局
/// @param index 所在index
- (void)sp_cellTapAction:(NSInteger)index {
    if (![self cellCanSelected]) {
        return;
    }
    MKSPDeviceModel *deviceModel = self.dataList[index];
    if (deviceModel.onLineState != MKSPDeviceModelStateOnline) {
        [self.view showCentralToast:@"Device is off-line!"];
        return;
    }
    MKSPDeviceDataController *vc = [[MKSPDeviceDataController alloc] init];
    vc.deviceModel = deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - MKSPDeviceModelDelegate
/// 当前设备离线
/// @param deviceID 当前设备的deviceID
- (void)sp_deviceOfflineWithDeviceID:(NSString *)deviceID {
    [self deviceModelOnlineStateChanged:MKSPDeviceModelStateOffline deviceID:deviceID];
}

#pragma mark - note
- (void)receiveNewDevice:(NSNotification *)note {
    //
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user)) {
        return;
    }
    MKSPDeviceModel *deviceModel = user[@"deviceModel"];
    deviceModel.delegate = self;
    [deviceModel startStateMonitoringTimer];
    
    NSInteger index = 0;
    BOOL contain = NO;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        MKSPDeviceModel *model = self.dataList[i];
        if ([model.deviceID isEqualToString:deviceModel.deviceID]) {
            index = i;
            contain = YES;
            break;
        }
    }
    if (contain) {
        //当前设备列表存在deviceID相同的设备，替换，本地数据库已经替换过了
        [self.dataList replaceObjectAtIndex:index withObject:deviceModel];
    }else {
        //不存在，则添加到设备列表
        [self.dataList addObject:deviceModel];
    }
    
    [self loadMainViews];
    [[MKSPServerManager shared] subscriptions:@[[deviceModel currentPublishedTopic]]];
}

- (void)receiveDeviceOnlineState:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"deviceID"]) || self.dataList.count == 0) {
        return;
    }
    [self deviceModelOnlineStateChanged:MKSPDeviceModelStateOnline deviceID:user[@"deviceID"]];
}

- (void)receiveDeviceNameChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"deviceID"]) || self.dataList.count == 0) {
        return;
    }
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        MKSPDeviceModel *deviceModel = self.dataList[i];
        if ([deviceModel.deviceID isEqualToString:user[@"deviceID"]]) {
            deviceModel.deviceName = user[@"deviceName"];
            index = i;
            break;
        }
    }
    [self.tableView mk_reloadRow:index inSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

- (void)receiveDeleteDevice:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"deviceID"]) || self.dataList.count == 0) {
        return;
    }
    MKSPDeviceModel *deviceModel = nil;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        MKSPDeviceModel *model = self.dataList[i];
        if ([model.deviceID isEqualToString:user[@"deviceID"]]) {
            deviceModel = model;
            break;
        }
    }
    
    if (!deviceModel) {
        return;
    }
    [[MKSPServerManager shared] unsubscriptions:@[[deviceModel currentPublishedTopic]]];
    [self.dataList removeObject:deviceModel];
    
    [self loadMainViews];
}

/// 当前MQTT服务器连接状态发生改变
- (void)serverManagerStateChanged {
    if ([MKSPServerManager shared].state == MKSPMQTTSessionManagerStateConnecting) {
        [self.loadingView showText:@"Connecting..." superView:self.titleLabel animated:YES];
        return;
    }
    if ([MKSPServerManager shared].state == MKSPMQTTSessionManagerStateConnected) {
        [self.loadingView hidden];
        self.defaultTitle = @"MKScannerPro";
        return;
    }
    if ([MKSPServerManager shared].state == MKSPMQTTSessionManagerStateError) {
        [self.loadingView hidden];
        self.defaultTitle = @"Connect Failed";
        return;
    }
}

- (void)networkStatusChanged {
    if (![[MKSPNetworkManager sharedInstance] currentNetworkAvailable]) {
        self.defaultTitle = @"Network Unreachable";
        return;
    }
}

#pragma mark - event method
- (void)addButtonPressed {
    if (!ValidDict([MKSPServerManager shared].serverParams)) {
        //如果MQTT服务器参数不存在，则去引导用户添加服务器参数，让app连接MQTT服务器
        [self leftButtonMethod];
        return;
    }
    //MQTT服务器参数存在，则添加设备
    MKSPScanPageController *vc = [[MKSPScanPageController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method
- (void)loadMainViews {
    if (self.tableView.superview) {
        [self.tableView removeFromSuperview];
    }
    if (self.addView.superview) {
        [self.addView removeFromSuperview];
    }
    if (!ValidArray(self.dataList)) {
        //没有设备的情况下，隐藏设备列表，显示添加设备页面
        [self.view addSubview:self.addView];
        [self.addView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(defaultTopInset);
            make.bottom.mas_equalTo(self.footerView.mas_top);
        }];
        return;
    }
    //有设备了，显示设备列表
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(self.footerView.mas_top);
    }];
    [self.tableView reloadData];
}

- (void)readDataFromDatabase {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKSPDeviceListDatabaseManager readLocalDeviceWithSucBlock:^(NSArray<MKSPDeviceModel *> * _Nonnull deviceList) {
        [[MKHudManager share] hide];
        [self loadTopics:deviceList];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)loadTopics:(NSArray <MKSPDeviceModel *>*)deviceList {
    NSMutableArray *topicList = [NSMutableArray array];
    for (NSInteger i = 0; i < deviceList.count; i ++) {
        MKSPDeviceModel *deviceModel = deviceList[i];
        deviceModel.delegate = self;
        [self.dataList addObject:deviceModel];
        [topicList addObject:[deviceModel currentPublishedTopic]];
    }
    [self loadMainViews];
    [[MKSPServerManager shared] subscriptions:topicList];
}

- (void)deviceModelOnlineStateChanged:(MKSPDeviceModelState)state deviceID:(NSString *)deviceID {
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        MKSPDeviceModel *deviceModel = self.dataList[i];
        if ([deviceModel.deviceID isEqualToString:deviceID]) {
            deviceModel.onLineState = state;
            if (state == MKSPDeviceModelStateOnline) {
                //在线状态开启监听
                [deviceModel startStateMonitoringTimer];
            }
            break;
        }
    }
    [self needRefreshList];
}

/**
 当有cell右侧的删除按钮出现时，不能触发点击事件
 
 @return YES可点击，NO不可点击
 */
- (BOOL)cellCanSelected{
    BOOL canSelected = YES;
    NSArray *arrCells = [self.tableView visibleCells];
    for (int i = 0; i < [arrCells count]; i++) {
        UITableViewCell *cell = arrCells[i];
        if ([cell isKindOfClass:MKSPDeviceListCell.class]) {
            MKSPDeviceListCell *tempCell = (MKSPDeviceListCell *)cell;
            if ([tempCell canReset]) {
                [tempCell resetCellFrame];
                canSelected = NO;
            }
        }
    }
    return canSelected;
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNewDevice:)
                                                 name:@"mk_sp_addNewDeviceSuccessNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceOnlineState:)
                                                 name:MKSPReceiveDeviceNetStateNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceNameChanged:)
                                                 name:@"mk_sp_deviceNameChangedNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeleteDevice:)
                                                 name:@"mk_sp_deleteDeviceNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(serverManagerStateChanged)
                                                 name:MKSPMQTTSessionManagerStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkStatusChanged)
                                                 name:MKSPNetworkStatusChangedNotification
                                               object:nil];
}

#pragma mark - 定时刷新

- (void)needRefreshList {
    //标记需要刷新
    self.isNeedRefresh = YES;
    //唤醒runloop
    CFRunLoopWakeUp(CFRunLoopGetMain());
}

- (void)runloopObserver {
    @weakify(self);
    __block NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    self.observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        @strongify(self);
        if (activity == kCFRunLoopBeforeWaiting) {
            //runloop空闲的时候刷新需要处理的列表,但是需要控制刷新频率
            NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
            if (currentInterval - timeInterval < kRefreshInterval) {
                return;
            }
            timeInterval = currentInterval;
            if (self.isNeedRefresh) {
                [self.tableView reloadData];
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"MKScannerPro";
    [self.rightButton setImage:LOADICON(@"MKScannerPro", @"MKSPDeviceListController", @"sp_aboutMenuIcon.png") forState:UIControlStateNormal];
    [self.leftButton setImage:LOADICON(@"MKScannerPro", @"MKSPDeviceListController", @"sp_menuIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.footerView];
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
        make.height.mas_equalTo(60.f);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (MKSPAddDeviceView *)addView {
    if (!_addView) {
        _addView = [[MKSPAddDeviceView alloc] init];
    }
    return _addView;
}

- (MKSPEasyShowView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[MKSPEasyShowView alloc] init];
    }
    return _loadingView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = COLOR_WHITE_MACROS;
        UIButton *addButton = [MKCustomUIAdopter customButtonWithTitle:@"Add Devices"
                                                                target:self
                                                                action:@selector(addButtonPressed)];
        [_footerView addSubview:addButton];
        [addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30.f);
            make.right.mas_equalTo(-30.f);
            make.centerY.mas_equalTo(_footerView.mas_centerY);
            make.height.mas_equalTo(40.f);
        }];
    }
    return _footerView;
}

@end
