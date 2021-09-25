//
//  MKSPDeviceDataController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPDeviceDataController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSDictionary+MKAdd.h"

#import "MKHudManager.h"

#import "MKSPServerManager.h"
#import "MKSPServerInterface.h"

#import "MKSPDeviceModel.h"

#import "MKSPDeviceDataTableHeaderView.h"
#import "MKSPDeviceDataPageCell.h"

#import "MKSPSettingController.h"
#import "MKSPUploadOptionController.h"

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKSPDeviceDataController ()<UITableViewDelegate,
UITableViewDataSource,
MKSPDeviceDataTableHeaderViewDelegate>

@property (nonatomic, strong)MKSPDeviceDataTableHeaderView *headerView;

@property (nonatomic, strong)MKSPDeviceDataTableHeaderViewModel *headerModel;

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@end

@implementation MKSPDeviceDataController

- (void)dealloc {
    NSLog(@"MKSPDeviceDataController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
    [self runloopObserver];
    [self addNotifications];
}

#pragma mark - super method
- (void)rightButtonMethod {
    MKSPSettingController *vc = [[MKSPSettingController alloc] init];
    vc.deviceModel = self.deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKSPDeviceDataPageCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKSPDeviceDataPageCell *cell = [MKSPDeviceDataPageCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - MKSPDeviceDataTableHeaderViewDelegate
- (void)sp_updateLoadButtonAction {
    MKSPUploadOptionController *vc = [[MKSPUploadOptionController alloc] init];
    vc.deviceModel = self.deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sp_scannerStatusChanged:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPServerInterface sp_configScanSwitchStatus:isOn
                                          scanTime:[self.headerModel.scanTime integerValue]
                                          deviceID:self.deviceModel.deviceID
                                        macAddress:self.deviceModel.macAddress
                                             topic:[self.deviceModel currentSubscribedTopic]
                                          sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = isOn;
        [self updateStatus];
    }
                                       failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)sp_scannerTimeChanged:(NSString *)time {
    self.headerModel.scanTime = time;
}

- (void)sp_saveButtonAction {
    if (!ValidStr(self.headerModel.scanTime) || [self.headerModel.scanTime integerValue] < 10 || [self.headerModel.scanTime integerValue] > 65535) {
        [self.view showCentralToast:@"Scan time 10~65535"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPServerInterface sp_configScanSwitchStatus:self.headerModel.isOn
                                          scanTime:[self.headerModel.scanTime integerValue]
                                          deviceID:self.deviceModel.deviceID
                                        macAddress:self.deviceModel.macAddress
                                             topic:[self.deviceModel currentSubscribedTopic]
                                          sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    }
                                       failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - note
- (void)receiveDeviceDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"device_id"]) || ![self.deviceModel.deviceID isEqualToString:user[@"device_info"][@"device_id"]]) {
        return;
    }
    NSArray *tempList = user[@"data"];
    if (!ValidArray(tempList)) {
        return;
    }
    for (NSDictionary *dic in tempList) {
        NSString *jsonString = [self convertToJsonData:dic];
        if (ValidStr(jsonString)) {
            MKSPDeviceDataPageCellModel *cellModel = [[MKSPDeviceDataPageCellModel alloc] init];
            cellModel.msg = jsonString;
            [self.dataList addObject:cellModel];
        }
    }
    [self needRefreshList];
}

- (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    if(!policyData && error){
        return @"";
    }
    //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
    NSString *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
    policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return policyStr;
}


- (void)receiveDeviceNameChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"]) || ![self.deviceModel.macAddress isEqualToString:user[@"macAddress"]]) {
        return;
    }
    self.defaultTitle = user[@"deviceName"];
}

- (void)receiveDeviceOffline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"deviceID"]) || ![self.deviceModel.deviceID isEqualToString:user[@"deviceID"]]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view showCentralToast:@"Device is off-line!"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)serverManagerStateChanged {
    if ([MKSPServerManager shared].state != MKMQTTSessionManagerStateConnected) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.view showCentralToast:@"APP is off-line!"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKSPServerInterface sp_readScanSwitchPramsWithDeviceID:self.deviceModel.deviceID
                                                 macAddress:self.deviceModel.macAddress
                                                      topic:[self.deviceModel currentSubscribedTopic]
                                                   sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = ([returnData[@"data"][@"scan_switch"] integerValue] == 1);
        self.headerModel.scanTime = [NSString stringWithFormat:@"%ld",(long)[returnData[@"data"][@"scan_time"] integerValue]];
        self.headerView.dataModel = self.headerModel;
        [self updateStatus];
    }
                                                failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method

/// 当扫描状态发生改变的时候，需要动态刷新UI，如果打开则添加扫描数据监听，如果关闭，则移除扫描数据监听
- (void)updateStatus {
    [self.dataList removeAllObjects];
    self.headerModel.totalNum = self.dataList.count;
    [self.headerView setDataModel:self.headerModel];
    [self.tableView reloadData];
    if (self.headerModel.isOn) {
        //打开
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDeviceDatas:)
                                                     name:MKSPReceiveDeviceDatasNotification
                                                   object:nil];
        return;
    }
    //关闭状态
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MKSPReceiveDeviceDatasNotification
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
                self.headerModel.totalNum = self.dataList.count;
                self.headerView.dataModel = self.headerModel;
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

#pragma mark - private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceNameChanged:)
                                                 name:@"mk_sp_deviceNameChangedNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceOffline:)
                                                 name:MKSPDeviceModelOfflineNotification
                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(serverManagerStateChanged)
//                                                 name:MKSPMQTTSessionManagerStateChangedNotification
//                                               object:nil];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = self.deviceModel.deviceName;
    [self.rightButton setImage:LOADICON(@"MKScannerPro", @"MKSPDeviceDataController", @"sp_moreIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (MKSPDeviceDataTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKSPDeviceDataTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 180.f)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (MKSPDeviceDataTableHeaderViewModel *)headerModel {
    if (!_headerModel) {
        _headerModel = [[MKSPDeviceDataTableHeaderViewModel alloc] init];
    }
    return _headerModel;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
