//
//  MKSPPFilterByRawDataController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPFilterByRawDataController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"

#import "MKSPPMQTTManager.h"
#import "MKSPPMQTTInterface.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

#import "MKSPPFilterByRawDataModel.h"

#import "MKSPPFilterByBeaconController.h"
#import "MKSPPFilterByUIDController.h"
#import "MKSPPFilterByURLController.h"
#import "MKSPPFilterByTLMController.h"
#import "MKSPPFilterByOtherController.h"

@interface MKSPPFilterByRawDataController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)MKSPPFilterByRawDataModel *dataModel;

@end

@implementation MKSPPFilterByRawDataController

- (void)dealloc {
    NSLog(@"MKSPPFilterByRawDataController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self readDataFromDevice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //iBeacon
        MKSPPFilterByBeaconController *vc = [[MKSPPFilterByBeaconController alloc] init];
        vc.pageType = mk_spp_filterByBeaconPageType_beacon;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Eddystone-UID
        MKSPPFilterByUIDController *vc = [[MKSPPFilterByUIDController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Eddystone-URL
        MKSPPFilterByURLController *vc = [[MKSPPFilterByURLController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //Eddystone-TLM
        MKSPPFilterByTLMController *vc = [[MKSPPFilterByTLMController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //MKiBeacon
        MKSPPFilterByBeaconController *vc = [[MKSPPFilterByBeaconController alloc] init];
        vc.pageType = mk_spp_filterByBeaconPageType_MKBeacon;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        //MKiBeacon&ACC
        MKSPPFilterByBeaconController *vc = [[MKSPPFilterByBeaconController alloc] init];
        vc.pageType = mk_spp_filterByBeaconPageType_MKBeaconAcc;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        //Other
        MKSPPFilterByOtherController *vc = [[MKSPPFilterByOtherController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //BeaconX Pro – ACC
        [self configFilterBXPACC:isOn];
        return;
    }
    if (index == 1) {
        //BeaconX Pro – T&H
        [self configFilterBXPTH:isOn];
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self updateCellStatus];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)configFilterBXPACC:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPPMQTTInterface spp_configFilterBXPACC:isOn
                                      deviceID:[MKSPDeviceModeManager shared].deviceID
                                    macAddress:[MKSPDeviceModeManager shared].macAddress
                                         topic:[MKSPDeviceModeManager shared].subscribedTopic
                                      sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        self.dataModel.bxpAcc = isOn;
    }
                                   failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)configFilterBXPTH:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPPMQTTInterface spp_configFilterBXPTH:isOn
                                     deviceID:[MKSPDeviceModeManager shared].deviceID
                                   macAddress:[MKSPDeviceModeManager shared].macAddress
                                        topic:[MKSPDeviceModeManager shared].subscribedTopic
                                     sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        MKTextSwitchCellModel *cellModel = self.section1List[1];
        cellModel.isOn = isOn;
        self.dataModel.bxpTH = isOn;
    }
                                  failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:1 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    [self.tableView reloadData];
}

- (void)updateCellStatus {
    MKNormalTextCellModel *cellModel1 = self.section0List[0];
    cellModel1.rightMsg = (self.dataModel.iBeacon ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel2 = self.section0List[1];
    cellModel2.rightMsg = (self.dataModel.uid ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel3 = self.section0List[2];
    cellModel3.rightMsg = (self.dataModel.url ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel4 = self.section0List[3];
    cellModel4.rightMsg = (self.dataModel.tlm ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel5 = self.section0List[4];
    cellModel5.rightMsg = (self.dataModel.MKiBeacon ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel6 = self.section0List[5];
    cellModel6.rightMsg = (self.dataModel.MKiBeaconAcc ? @"ON" : @"OFF");
    
    MKTextSwitchCellModel *cellModel7 = self.section1List[0];
    cellModel7.isOn = self.dataModel.bxpAcc;
    
    MKTextSwitchCellModel *cellModel8 = self.section1List[1];
    cellModel8.isOn = self.dataModel.bxpTH;
    
    MKNormalTextCellModel *cellModel9 = self.section2List[0];
    cellModel9.rightMsg = (self.dataModel.other ? @"ON" : @"OFF");
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.showRightIcon = YES;
    cellModel1.leftMsg = @"iBeacon";
    [self.section0List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.showRightIcon = YES;
    cellModel2.leftMsg = @"Eddystone-UID";
    [self.section0List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.showRightIcon = YES;
    cellModel3.leftMsg = @"Eddystone-URL";
    [self.section0List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.showRightIcon = YES;
    cellModel4.leftMsg = @"Eddystone-TLM";
    [self.section0List addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.showRightIcon = YES;
    cellModel5.leftMsg = @"MKiBeacon";
    [self.section0List addObject:cellModel5];
    
    MKNormalTextCellModel *cellModel6 = [[MKNormalTextCellModel alloc] init];
    cellModel6.showRightIcon = YES;
    cellModel6.leftMsg = @"MKiBeacon&ACC";
    [self.section0List addObject:cellModel6];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"BeaconX Pro – ACC";
    [self.section1List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"BeaconX Pro – T&H";
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.showRightIcon = YES;
    cellModel1.leftMsg = @"Other";
    [self.section2List addObject:cellModel1];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Filter by Raw Data";
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

- (MKSPPFilterByRawDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKSPPFilterByRawDataModel alloc] init];
    }
    return _dataModel;
}

@end
