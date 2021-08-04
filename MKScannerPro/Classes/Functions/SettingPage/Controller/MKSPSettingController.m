//
//  MKSPSettingController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/18.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPSettingController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertController.h"
#import "MKHudManager.h"
#import "MKSettingTextCell.h"

#import "MKSPDeviceModel.h"

#import "MKSPDeviceListDatabaseManager.h"

#import "MKSPServerInterface.h"

#import "MKSPDeviceInfoController.h"
#import "MKSPMQTTSettingForDeviceController.h"
#import "MKSPLEDSettingController.h"
#import "MKSPDataReportingController.h"
#import "MKSPNetworkStatusController.h"
#import "MKSPSystemTimeController.h"
#import "MKSPOTAController.h"
#import "MKSPConnectionSettingController.h"
#import "MKSPScanTimeoutOptionController.h"

@interface MKSPSettingController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *sectionHeaderList;

@property (nonatomic, strong)UITextField *localNameField;

@property (nonatomic, copy)NSString *localNameAsciiStr;

@end

@implementation MKSPSettingController

- (void)dealloc {
    NSLog(@"MKSPSettingController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self configLocalName];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.sectionHeaderList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //LED settings
        MKSPLEDSettingController *vc = [[MKSPLEDSettingController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Data reporting timeout
        MKSPDataReportingController *vc = [[MKSPDataReportingController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Network status reporting interval
        MKSPNetworkStatusController *vc = [[MKSPNetworkStatusController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //Connection timeout setting
        MKSPConnectionSettingController *vc = [[MKSPConnectionSettingController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //Scan timeout option
        MKSPScanTimeoutOptionController *vc = [[MKSPScanTimeoutOptionController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        //System time
        MKSPSystemTimeController *vc = [[MKSPSystemTimeController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        //OTA
        MKSPOTAController *vc = [[MKSPOTAController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        //Device information
        MKSPDeviceInfoController *vc = [[MKSPDeviceInfoController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        //MQTT settings for device
        MKSPMQTTSettingForDeviceController *vc = [[MKSPMQTTSettingForDeviceController alloc] init];
        vc.deviceModel = self.deviceModel;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        return cell;
    }
    MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    return cell;
}

#pragma mark - event method
- (void)resetButtonPressed {
    NSString *msg = @"After reset, the device will be removed from the device list, and relevant data will be totally cleared.";
    MKAlertController *alertView = [MKAlertController alertControllerWithTitle:@"Reset Device"
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:cancelAction];
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self resetDevice];
    }];
    [alertView addAction:moreAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)rebootButtonPressed {
    NSString *msg = @"Please confirm again whether to reboot the device.";
    MKAlertController *alertView = [MKAlertController alertControllerWithTitle:@"Reboot Device"
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:cancelAction];
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self rebootDevice];
    }];
    [alertView addAction:moreAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

#pragma mark - 修改设备本地名称
- (void)configLocalName{
    @weakify(self);
    NSString *msg = @"Note:The local name should be 1-20 characters.";
    MKAlertController *alertView = [MKAlertController alertControllerWithTitle:@"Edit Local Name"
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        @strongify(self);
        self.localNameField = nil;
        self.localNameField = textField;
        self.localNameAsciiStr = @"";
        [self.localNameField setPlaceholder:@"1-20 characters"];
        [self.localNameField addTarget:self
                                action:@selector(locaNameTextFieldValueChanged:)
                      forControlEvents:UIControlEventEditingChanged];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertView addAction:cancelAction];
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self saveDeviceLocalName];
    }];
    [alertView addAction:moreAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)locaNameTextFieldValueChanged:(UITextField *)textField{
    NSString *inputValue = textField.text;
    if (!ValidStr(inputValue)) {
        textField.text = @"";
        self.localNameAsciiStr = @"";
        return;
    }
    NSInteger strLen = inputValue.length;
    NSInteger dataLen = [inputValue dataUsingEncoding:NSUTF8StringEncoding].length;
    
    NSString *currentStr = self.localNameAsciiStr;
    if (dataLen == strLen) {
        //当前输入是ascii字符
        currentStr = inputValue;
    }
    if (currentStr.length > 20) {
        textField.text = [currentStr substringToIndex:20];
        self.localNameAsciiStr = [currentStr substringToIndex:20];
    }else {
        textField.text = currentStr;
        self.localNameAsciiStr = currentStr;
    }
}

- (void)saveDeviceLocalName {
    if (!ValidStr(self.localNameAsciiStr) || self.localNameAsciiStr.length > 20) {
        [self.view showCentralToast:@"The local name should be 1-20 characters."];
        return;
    }
    MKSPDeviceModel *deviceModel = [[MKSPDeviceModel alloc] init];
    deviceModel.deviceID = self.deviceModel.deviceID;
    deviceModel.clientID = self.deviceModel.clientID;
    deviceModel.deviceName = self.localNameAsciiStr;
    deviceModel.subscribedTopic = self.deviceModel.subscribedTopic;
    deviceModel.publishedTopic = self.deviceModel.publishedTopic;
    deviceModel.macAddress = self.deviceModel.macAddress;
    [[MKHudManager share] showHUDWithTitle:@"Save..." inView:self.view isPenetration:NO];
    [MKSPDeviceListDatabaseManager insertDeviceList:@[deviceModel] sucBlock:^{
        [[MKHudManager share] hide];
        self.deviceModel.deviceName = self.localNameAsciiStr;
        self.defaultTitle = self.localNameAsciiStr;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_sp_deviceNameChangedNotification"
                                                            object:nil
                                                          userInfo:@{
                                                              @"macAddress":self.deviceModel.macAddress,
                                                              @"deviceName":self.localNameAsciiStr
                                                          }];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - 设备复位
- (void)resetDevice {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKSPServerInterface sp_configDeviceResetWithDeviceID:self.deviceModel.deviceID
                                               macAddress:self.deviceModel.macAddress
                                                    topic:[self.deviceModel currentSubscribedTopic]
                                                 sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self removeDevice];
    }
                                              failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)removeDevice {
    [[MKHudManager share] showHUDWithTitle:@"Delete..." inView:self.view isPenetration:NO];
    [MKSPDeviceListDatabaseManager deleteDeviceWithMacAddress:self.deviceModel.macAddress sucBlock:^{
        [[MKHudManager share] hide];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_sp_deleteDeviceNotification"
                                                            object:nil
                                                          userInfo:@{@"macAddress":self.deviceModel.macAddress}];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - 设备重启
- (void)rebootDevice {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKSPServerInterface sp_rebootDeviceWithDeviceID:self.deviceModel.deviceID
                                          macAddress:self.deviceModel.macAddress
                                               topic:[self.deviceModel currentSubscribedTopic]
                                            sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success!"];
    }
                                         failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSectionHeaderList];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"LED status option";
    [self.section0List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"Data report timeout";
    [self.section0List addObject:cellModel2];
    
    MKSettingTextCellModel *cellModel3 = [[MKSettingTextCellModel alloc] init];
    cellModel3.leftMsg = @"Network status report period";
    [self.section0List addObject:cellModel3];
    
    MKSettingTextCellModel *cellModel4 = [[MKSettingTextCellModel alloc] init];
    cellModel4.leftMsg = @"Connection timeout option";
    [self.section0List addObject:cellModel4];
    
    MKSettingTextCellModel *cellModel5 = [[MKSettingTextCellModel alloc] init];
    cellModel5.leftMsg = @"Scan timeout option";
    [self.section0List addObject:cellModel5];
    
    MKSettingTextCellModel *cellModel6 = [[MKSettingTextCellModel alloc] init];
    cellModel6.leftMsg = @"System time";
    [self.section0List addObject:cellModel6];
}

- (void)loadSection1Datas {
    MKSettingTextCellModel *cellModel = [[MKSettingTextCellModel alloc] init];
    cellModel.leftMsg = @"OTA";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"Device information";
    [self.section2List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"MQTT settings for device";
    [self.section2List addObject:cellModel2];
}

- (void)loadSectionHeaderList {
    for (NSInteger i = 0; i < 3; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.sectionHeaderList addObject:headerModel];
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = self.deviceModel.deviceName;
    [self.rightButton setImage:LOADICON(@"MKScannerPro", @"MKSPSettingController", @"sp_editIcon.png")
                      forState:UIControlStateNormal];
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
        
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [self footerView];
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)sectionHeaderList {
    if (!_sectionHeaderList) {
        _sectionHeaderList = [NSMutableArray array];
    }
    return _sectionHeaderList;
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 120.f)];
    footerView.backgroundColor = RGBCOLOR(242, 242, 242);
    
    UIButton *removeButton = [MKCustomUIAdopter customButtonWithTitle:@"Reboot Device"
                                                               target:self
                                                               action:@selector(rebootButtonPressed)];
    removeButton.frame = CGRectMake(50.f, 20.f, kViewWidth - 2 * 50.f, 40.f);
    
    UIButton *resetButton = [MKCustomUIAdopter customButtonWithTitle:@"Reset Device"
                                                              target:self
                                                              action:@selector(resetButtonPressed)];
    resetButton.frame = CGRectMake(50.f, 20.f + 20.f + 40.f, kViewWidth - 2 * 50.f, 40.f);
    
    [footerView addSubview:removeButton];
    [footerView addSubview:resetButton];
    
    return footerView;
}

@end
