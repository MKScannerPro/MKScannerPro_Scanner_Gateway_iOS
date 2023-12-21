//
//  MKSPAUploadOptionController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPAUploadOptionController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKFilterConditionCell.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

#import "MKSPAUploadOptionModel.h"

#import "MKSPAMQTTInterface.h"

#import "MKSPATypeFilterController.h"
#import "MKSPAFilterConditionController.h"
#import "MKSPADuplicateDataFilterController.h"
#import "MKSPAUploadDataOptionController.h"

@interface MKSPAUploadOptionController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKFilterConditionCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKSPAUploadOptionModel *dataModel;

@end

@implementation MKSPAUploadOptionController

- (void)dealloc {
    NSLog(@"MKSPAUploadOptionController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self readDataFromServer];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4 || section == 5) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *header = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    header.headerModel = self.headerList[section];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Beacon type filter
        MKSPATypeFilterController *vc = [[MKSPATypeFilterController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2) {
        //Filter condition A 、Filter condition B
        MKSPAFilterConditionController *vc = [[MKSPAFilterConditionController alloc] init];
        vc.conditionType = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        //Duplicate data filter
        MKSPADuplicateDataFilterController *vc = [[MKSPADuplicateDataFilterController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 5 && indexPath.row == 0) {
        //Upload data option
        MKSPAUploadDataOptionController *vc = [[MKSPAUploadDataOptionController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return (self.dataModel.beaconDataFilter ? self.section2List.count : 0);
    }
    if (section == 3) {
        return (self.dataModel.beaconDataFilter ? self.section3List.count : 0);
    }
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return self.section5List.count;
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
    if (indexPath.section == 2) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 3) {
        MKFilterConditionCell *cell = [MKFilterConditionCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section5List[indexPath.row];
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Beacon data filter
        self.dataModel.beaconDataFilter = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        [self.tableView reloadData];
        return;
    }
}

#pragma mark - MKFilterConditionCellDelegate
/// 关于发生改变
/// @param conditionIndex 0:And,1:Or
- (void)mk_filterConditionsChanged:(NSInteger)conditionIndex {
    mk_spa_scanFilterConditionShip ship = mk_spa_scanFilterConditionShipOR;
    if (conditionIndex == 0) {
        ship = mk_spa_scanFilterConditionShipAND;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_configScanFilterConditions:ship deviceID:[MKSPDeviceModeManager shared].deviceID
                                            macAddress:[MKSPDeviceModeManager shared].macAddress
                                                 topic:[MKSPDeviceModeManager shared].subscribedTopic
                                              sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.dataModel.conditionIndex = conditionIndex;
        MKFilterConditionCellModel *cellModel3 = self.section3List[0];
        cellModel3.conditionIndex = self.dataModel.conditionIndex;
    }
                                           failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKSPAMQTTInterface spa_readScanFilterConditionsWithDeviceID:[MKSPDeviceModeManager shared].deviceID
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
    self.dataModel.filterConditionA = ([dic[@"rule1_switch"] integerValue] == 1);
    self.dataModel.filterConditionB = ([dic[@"rule2_switch"] integerValue] == 1);
    self.dataModel.conditionIndex = ([dic[@"relation"] isEqualToString:@"AND"] ? 0 : 1);
    MKNormalTextCellModel *cellModel1 = self.section2List[0];
    cellModel1.rightMsg = (self.dataModel.filterConditionA ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel2 = self.section2List[1];
    cellModel2.rightMsg = (self.dataModel.filterConditionB ? @"ON" : @"OFF");
    
    MKFilterConditionCellModel *cellModel3 = self.section3List[0];
    cellModel3.enable = (self.dataModel.filterConditionA && self.dataModel.filterConditionB);
    cellModel3.conditionIndex = self.dataModel.conditionIndex;
    
    [self.tableView reloadData];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadHeaderListDatas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Beacon Type Filter";
    cellModel.showRightIcon = YES;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Beacon Data Filter";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Filter Condition A";
    cellModel1.showRightIcon = YES;
    cellModel1.rightMsg = @"OFF";
    [self.section2List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Filter Condition B";
    cellModel2.showRightIcon = YES;
    cellModel2.rightMsg = @"OFF";
    [self.section2List addObject:cellModel2];
}

- (void)loadSection3Datas {
    MKFilterConditionCellModel *cellModel = [[MKFilterConditionCellModel alloc] init];
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Duplicate Data Filter";
    cellModel.showRightIcon = YES;
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Upload Data Option";
    cellModel.showRightIcon = YES;
    [self.section5List addObject:cellModel];
}

- (void)loadHeaderListDatas {
    for (NSInteger i = 0; i < 6; i ++) {
        MKTableSectionLineHeaderModel *model = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:model];
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKSPDeviceModeManager shared].deviceName;
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

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKSPAUploadOptionModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKSPAUploadOptionModel alloc] init];
    }
    return _dataModel;
}

@end
