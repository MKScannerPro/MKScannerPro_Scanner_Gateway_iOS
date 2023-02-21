//
//  MKSPLEDSettingController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPLEDSettingController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKTextSwitchCell.h"
#import "MKHudManager.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

@interface MKSPLedSettingModel : NSObject

@property (nonatomic, assign)BOOL ble_advertising;

@property (nonatomic, assign)BOOL ble_connected;

@property (nonatomic, assign)BOOL server_connecting;

@property (nonatomic, assign)BOOL server_connected;

@end

@implementation MKSPLedSettingModel
@end

@interface MKSPLEDSettingController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKSPLedSettingModel *settingModel;

@end

@implementation MKSPLEDSettingController

- (void)dealloc {
    NSLog(@"MKSPLEDSettingController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
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
    if (index == 0) {
        //Bluetooth advertising indicator
        self.settingModel.ble_advertising = isOn;
        return;
    }
    if (index == 1) {
        //Bluetooth connected indicator
        self.settingModel.ble_connected = isOn;
        return;
    }
    if (index == 2) {
        //WIFI connecting indicator
        self.settingModel.server_connecting = isOn;
        return;
    }
    if (index == 3) {
        //WIFI connected indicator
        self.settingModel.server_connected = isOn;
        return;
    }
}

#pragma mark - event method
- (void)confirmButtonPressed {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [self.protocol sp_configIndicatorLightStatus:self.settingModel.ble_advertising
                                   ble_connected:self.settingModel.ble_connected
                               server_connecting:self.settingModel.server_connecting
                                server_connected:self.settingModel.server_connected
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

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [self.protocol sp_readIndicatorLightStatusWithDeviceID:[MKSPDeviceModeManager shared].deviceID
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

#pragma mark - private method
- (void)updateCellData:(NSDictionary *)dic {
    self.settingModel.ble_advertising = ([dic[@"ble_adv"] integerValue] == 1);
    self.settingModel.ble_connected = ([dic[@"ble_connected"] integerValue] == 1);
    self.settingModel.server_connecting = ([dic[@"server_connecting"] integerValue] == 1);
    self.settingModel.server_connected = ([dic[@"server_connected"] integerValue] == 1);
    [self loadSectionDatas];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Bluetooth advertising indicator";
    cellModel1.isOn = self.settingModel.ble_advertising;
    [self.dataList addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Bluetooth connected indicator";
    cellModel2.isOn = self.settingModel.ble_connected;
    [self.dataList addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Server connecting indicator";
    cellModel3.isOn = self.settingModel.server_connecting;
    [self.dataList addObject:cellModel3];
    
    MKTextSwitchCellModel *cellModel4 = [[MKTextSwitchCellModel alloc] init];
    cellModel4.index = 3;
    cellModel4.msg = @"Server connected indicator";
    cellModel4.isOn = self.settingModel.server_connected;
    [self.dataList addObject:cellModel4];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"LED status option";
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

- (MKSPLedSettingModel *)settingModel {
    if (!_settingModel) {
        _settingModel = [[MKSPLedSettingModel alloc] init];
    }
    return _settingModel;
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 100.f)];
    footerView.backgroundColor = COLOR_WHITE_MACROS;
    
    UIButton *confirmButton = [MKCustomUIAdopter customButtonWithTitle:@"Confirm"
                                                                target:self
                                                                action:@selector(confirmButtonPressed)];
    confirmButton.frame = CGRectMake(30.f, 30.f, kViewWidth - 2 * 30.f, 40.f);
    [footerView addSubview:confirmButton];
    
    return footerView;
}

@end
