//
//  MKSPATypeFilterController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPATypeFilterController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

#import "MKSPAMQTTInterface.h"

#import "MKSPATypeFilterModel.h"

@interface MKSPATypeFilterController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKSPATypeFilterModel *dataModel;

@end

@implementation MKSPATypeFilterController

- (void)dealloc {
    NSLog(@"MKSPATypeFilterController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_configBeaconTypeFilter:self.dataModel
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

#pragma mark - UITableViewDataSource
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
        //iBeacon
        self.dataModel.iBeacon = isOn;
        return;
    }
    if (index == 1) {
        //Eddystone-UID
        self.dataModel.uid = isOn;
        return;
    }
    if (index == 2) {
        //Eddystone-URL
        self.dataModel.url = isOn;
        return;
    }
    if (index == 3) {
        //Eddystone-TLM
        self.dataModel.tlm = isOn;
        return;
    }
    if (index == 4) {
        //MKiBeacon
        self.dataModel.MKiBeacon = isOn;
        return;
    }
    if (index == 5) {
        //MKiBeacon&ACC
        self.dataModel.MKiBeaconACC = isOn;
        return;
    }
    if (index == 6) {
        //BeaconX Pro – ACC
        self.dataModel.bxpAcc = isOn;
        return;
    }
    if (index == 7) {
        //BeaconX Pro – ACC
        self.dataModel.bxpTH = isOn;
        return;
    }
    if (index == 8) {
        //Unknown
        self.dataModel.unknown = isOn;
        return;
    }
}

- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_readBeaconTypeFilterDatasWithDeviceID:[MKSPDeviceModeManager shared].deviceID
                                                       macAddress:[MKSPDeviceModeManager shared].macAddress
                                                            topic:[MKSPDeviceModeManager shared].subscribedTopic
                                                         sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self updateCellDatas:returnData[@"data"]];
    }
                                                      failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method
- (void)updateCellDatas:(NSDictionary *)dic {
    self.dataModel.iBeacon = ([dic[@"ibeacon"] integerValue] == 1);
    self.dataModel.uid = ([dic[@"eddystone_uid"] integerValue] == 1);
    self.dataModel.url = ([dic[@"eddystone_url"] integerValue] == 1);
    self.dataModel.tlm = ([dic[@"eddystone_tlm"] integerValue] == 1);
    self.dataModel.MKiBeacon = ([dic[@"MK_iBeacon"] integerValue] == 1);
    self.dataModel.MKiBeaconACC = ([dic[@"MK_ACC"] integerValue] == 1);
    self.dataModel.bxpAcc = ([dic[@"BXP_ACC"] integerValue] == 1);
    self.dataModel.bxpTH = ([dic[@"BXP_T&H"] integerValue] == 1);
    self.dataModel.unknown = ([dic[@"unknown"] integerValue] == 1);
    [self loadSectionDatas];
}

#pragma mark - loadSectionDatas

- (void)loadSectionDatas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"iBeacon";
    cellModel1.isOn = self.dataModel.iBeacon;
    [self.dataList addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Eddystone-UID";
    cellModel2.isOn = self.dataModel.uid;
    [self.dataList addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Eddystone-URL";
    cellModel3.isOn = self.dataModel.url;
    [self.dataList addObject:cellModel3];
    
    MKTextSwitchCellModel *cellModel4 = [[MKTextSwitchCellModel alloc] init];
    cellModel4.index = 3;
    cellModel4.msg = @"Eddystone-TLM";
    cellModel4.isOn = self.dataModel.tlm;
    [self.dataList addObject:cellModel4];
    
    MKTextSwitchCellModel *cellModel5 = [[MKTextSwitchCellModel alloc] init];
    cellModel5.index = 4;
    cellModel5.msg = @"MKiBeacon";
    cellModel5.isOn = self.dataModel.MKiBeacon;
    [self.dataList addObject:cellModel5];
    
    MKTextSwitchCellModel *cellModel6 = [[MKTextSwitchCellModel alloc] init];
    cellModel6.index = 5;
    cellModel6.msg = @"MKiBeacon&ACC";
    cellModel6.isOn = self.dataModel.MKiBeaconACC;
    [self.dataList addObject:cellModel6];
    
    MKTextSwitchCellModel *cellModel7 = [[MKTextSwitchCellModel alloc] init];
    cellModel7.index = 6;
    cellModel7.msg = @"BeaconX Pro – ACC";
    cellModel7.isOn = self.dataModel.bxpAcc;
    [self.dataList addObject:cellModel7];
    
    MKTextSwitchCellModel *cellModel8 = [[MKTextSwitchCellModel alloc] init];
    cellModel8.index = 7;
    cellModel8.msg = @"BeaconX Pro - T&H";
    cellModel8.isOn = self.dataModel.bxpTH;
    [self.dataList addObject:cellModel8];
    
    MKTextSwitchCellModel *cellModel9 = [[MKTextSwitchCellModel alloc] init];
    cellModel9.index = 8;
    cellModel9.msg = @"Unknown";
    cellModel9.isOn = self.dataModel.unknown;
    [self.dataList addObject:cellModel9];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Beacon Type filter";
    [self.rightButton setImage:LOADICON(@"MKScannerPro", @"MKSPATypeFilterController", @"sp_saveIcon.png") forState:UIControlStateNormal];
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

- (MKSPATypeFilterModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKSPATypeFilterModel alloc] init];
    }
    return _dataModel;
}

@end
