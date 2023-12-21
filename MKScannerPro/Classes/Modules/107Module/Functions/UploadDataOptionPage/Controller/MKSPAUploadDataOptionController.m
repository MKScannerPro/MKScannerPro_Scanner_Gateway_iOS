//
//  MKSPAUploadDataOptionController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPAUploadDataOptionController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

#import "MKSPAMQTTInterface.h"

#import "MKSPAUploadDataOptionModel.h"

@interface MKSPAUploadDataOptionController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKSPAUploadDataOptionModel *dataModel;

@end

@implementation MKSPAUploadDataOptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_configUploadDataOption:self.dataModel
                                          deviceID:[MKSPDeviceModeManager shared].deviceID
                                        macAddress:[MKSPDeviceModeManager shared].macAddress
                                             topic:[MKSPDeviceModeManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    }
                                       failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    MKTextSwitchCellModel *cellModel = self.dataList[index];
    cellModel.isOn = isOn;
    if (index == 0) {
        //Timestamp
        self.dataModel.timestamp = isOn;
        return;
    }
    if (index == 1) {
        //Device type
        self.dataModel.deviceType = isOn;
        return;
    }
    if (index == 2) {
        //RSSI
        self.dataModel.rssi = isOn;
        return;
    }
    if (index == 3) {
        //RAW data
        self.dataModel.rawData = isOn;
        return;
    }
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_readUploadDataOptionWithDeviceID:[MKSPDeviceModeManager shared].deviceID
                                                  macAddress:[MKSPDeviceModeManager shared].macAddress
                                                       topic:[MKSPDeviceModeManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.dataModel.timestamp = ([returnData[@"data"][@"timestamp"] integerValue] == 1);
        self.dataModel.deviceType = ([returnData[@"data"][@"type"] integerValue] == 1);
        self.dataModel.rssi = ([returnData[@"data"][@"rssi"] integerValue] == 1);
        self.dataModel.rawData = ([returnData[@"data"][@"raw"] integerValue] == 1);
        [self loadSectionDatas];
    }
                                                 failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Timestamp";
    cellModel1.isOn = self.dataModel.timestamp;
    [self.dataList addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Device type";
    cellModel2.isOn = self.dataModel.deviceType;
    [self.dataList addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"RSSI";
    cellModel3.isOn = self.dataModel.rssi;
    [self.dataList addObject:cellModel3];
    
    MKTextSwitchCellModel *cellModel4 = [[MKTextSwitchCellModel alloc] init];
    cellModel4.index = 3;
    cellModel4.msg = @"RAW data";
    cellModel4.isOn = self.dataModel.rawData;
    [self.dataList addObject:cellModel4];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Upload data option";
    [self.rightButton setImage:LOADICON(@"MKScannerPro", @"MKSPAUploadDataOptionController", @"sp_saveIcon.png") forState:UIControlStateNormal];
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
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MKSPAUploadDataOptionModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKSPAUploadDataOptionModel alloc] init];
    }
    return _dataModel;
}

@end
