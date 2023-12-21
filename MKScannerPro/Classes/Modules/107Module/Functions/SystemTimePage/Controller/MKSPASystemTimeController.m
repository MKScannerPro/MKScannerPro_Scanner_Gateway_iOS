//
//  MKSPASystemTimeController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPASystemTimeController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKHudManager.h"
#import "MKTextButtonCell.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

#import "MKSPAMQTTInterface.h"

@interface MKSPASystemTimeController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, assign)NSInteger timeZone;

@property (nonatomic, strong)dispatch_source_t readTimer;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)NSArray *timeZoneList;

@end

@implementation MKSPASystemTimeController

- (void)dealloc {
    NSLog(@"MKSPASystemTimeController销毁");
    if (self.readTimer) {
        dispatch_cancel(self.readTimer);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeZone = 12;
    [self loadSubViews];
    [self loadSectionDatas];
    [self readDataFromServer];
    [self startReceiveTimer];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    [self syncTimeZoneToDevice:dataListIndex];
}

#pragma mark - event method
- (void)syncButtonPressed {
    [self syncTimeZoneToDevice:self.timeZone];
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_readDeviceUTCWithDeviceID:[MKSPDeviceModeManager shared].deviceID
                                           macAddress:[MKSPDeviceModeManager shared].macAddress
                                                topic:[MKSPDeviceModeManager shared].subscribedTopic
                                             sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self updateCellData:returnData[@"data"]];
    }
                                          failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)syncTimeZoneToDevice:(NSInteger)timeZone {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_configDeviceTimeZone:timeZone - 12
                                        deviceID:[MKSPDeviceModeManager shared].deviceID
                                      macAddress:[MKSPDeviceModeManager shared].macAddress
                                           topic:[MKSPDeviceModeManager shared].subscribedTopic
                                        sucBlock:^(id  _Nonnull returnData) {
        self.timeZone = timeZone;
        MKTextButtonCellModel *cellModel = self.dataList[0];
        cellModel.dataListIndex = self.timeZone;
        [[MKHudManager share] hide];
        [self readDataFromServer];
    }
                                     failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView reloadData];
    }];
}

#pragma mark - private method
- (void)updateCellData:(NSDictionary *)dic {
    NSString *timeStamp = dic[@"timestamp"];
    if (!ValidStr(timeStamp)) {
        return;
    }
    self.timeZone = [dic[@"time_zone"] integerValue] + 12;
    NSArray *timeStampList = [timeStamp componentsSeparatedByString:@"&"];
    if (timeStampList.count != 2) {
        return;
    }
    
    NSArray *timeList = [timeStampList[1] componentsSeparatedByString:@":"];
    if (timeList.count != 3) {
        return;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@%@ %@:%@ %@",@"Device time:",timeStampList[0],timeList[0],timeList[1],self.timeZoneList[self.timeZone]];
    MKTextButtonCellModel *cellModel = self.dataList[0];
    cellModel.dataListIndex = self.timeZone;
    [self.tableView reloadData];
}

- (void)startReceiveTimer {
    @weakify(self);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.readTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.readTimer, dispatch_walltime(NULL, 0), 30 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.readTimer, ^{
        @strongify(self);
        moko_dispatch_main_safe(^{
            [self readDataFromServer];
        });
    });
    dispatch_resume(self.readTimer);
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"TimeZone";
    cellModel.dataList = self.timeZoneList;
    [self.dataList addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"System time";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.tableFooterView = [self footerView];
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorFromRGB(0xcccccc);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = MKFont(13.f);
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

- (NSArray *)timeZoneList {
    if (!_timeZoneList) {
        _timeZoneList = @[@"UTC-12",@"UTC-11",@"UTC-10",@"UTC-09",
                          @"UTC-08",@"UTC-07",@"UTC-06",@"UTC-05",
                          @"UTC-04",@"UTC-03",@"UTC-02",@"UTC-01",
                          @"UTC+00",@"UTC+01",@"UTC+02",@"UTC+03",
                          @"UTC+04",@"UTC+05",@"UTC+06",@"UTC+07",
                          @"UTC+08",@"UTC+09",@"UTC+10",@"UTC+11",
                          @"UTC+12"];
    }
    return _timeZoneList;
}

- (UIView *)headerView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 55.f)];
    headerView.backgroundColor = COLOR_WHITE_MACROS;
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 10.f, 110.f, MKFont(15.f).lineHeight)];
    msgLabel.textColor = DEFAULT_TEXT_COLOR;
    msgLabel.textAlignment = NSTextAlignmentLeft;
    msgLabel.font = MKFont(15.f);
    msgLabel.text = @"System time";
    [headerView addSubview:msgLabel];
    
    UIButton *syncButton = [MKCustomUIAdopter customButtonWithTitle:@"Sync"
                                                             target:self
                                                             action:@selector(syncButtonPressed)];
    syncButton.frame = CGRectMake(kViewWidth - 15.f - 45.f, 7.f, 45.f, 30.f);
    [headerView addSubview:syncButton];
    
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 30.f, 110.f, MKFont(15.f).lineHeight)];
    noteLabel.textAlignment = NSTextAlignmentLeft;
    noteLabel.textColor = UIColorFromRGB(0xcccccc);
    noteLabel.font = MKFont(12.f);
    noteLabel.text = @"Date&Time";
    [headerView addSubview:noteLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15.f, 55.f - CUTTING_LINE_HEIGHT, kViewWidth - 2 * 15.f, CUTTING_LINE_HEIGHT)];
    lineView.backgroundColor = CUTTING_LINE_COLOR;
    [headerView addSubview:lineView];
    
    return headerView;
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 120.f)];
    footerView.backgroundColor = COLOR_WHITE_MACROS;
    
    
    self.timeLabel.frame = CGRectMake(30.f, 30.f, kViewWidth - 2 * 30.f, 40.f);
    [footerView addSubview:self.timeLabel];
    
    return footerView;
}

@end
