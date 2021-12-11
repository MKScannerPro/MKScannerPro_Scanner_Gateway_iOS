//
//  MKSPPUploadOptionController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPUploadOptionController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKNormalSliderCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKCustomUIAdopter.h"

#import "MKSPDeviceModel.h"

#import "MKSPPUploadOptionModel.h"

#import "MKSPPFilterCell.h"

#import "MKSPPDuplicateDataFilterController.h"
#import "MKSPPUploadDataOptionController.h"

#import "MKSPPFilterByMacController.h"
#import "MKSPPFilterByAdvNameController.h"
#import "MKSPPFilterByRawDataController.h"

@interface MKSPPUploadOptionController ()<UITableViewDelegate,
UITableViewDataSource,
MKNormalSliderCellDelegate,
MKSPPFilterCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *sectionHeaderList;

@property (nonatomic, strong)MKSPPUploadOptionModel *dataModel;

@end

@implementation MKSPPUploadOptionController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //本页面禁止右划退出手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self configDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 4 || section == 5) {
        return 10;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90.f;
    }
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.sectionHeaderList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        MKNormalTextCellModel *cellModel = self.section2List[indexPath.row];
        if (ValidStr(cellModel.methodName) && [self respondsToSelector:NSSelectorFromString(cellModel.methodName)]) {
            [self performSelector:NSSelectorFromString(cellModel.methodName) withObject:nil];
        }
        return;
    }
    if (indexPath.section == 4) {
        MKNormalTextCellModel *cellModel = self.section4List[indexPath.row];
        if (ValidStr(cellModel.methodName) && [self respondsToSelector:NSSelectorFromString(cellModel.methodName)]) {
            [self performSelector:NSSelectorFromString(cellModel.methodName) withObject:nil];
        }
        return;
    }
    if (indexPath.section == 5) {
        MKNormalTextCellModel *cellModel = self.section5List[indexPath.row];
        if (ValidStr(cellModel.methodName) && [self respondsToSelector:NSSelectorFromString(cellModel.methodName)]) {
            [self performSelector:NSSelectorFromString(cellModel.methodName) withObject:nil];
        }
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
    if (section == 3) {
        return self.section3List.count;
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
        MKNormalSliderCell *cell = [MKNormalSliderCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKSPPFilterCell *cell = [MKSPPFilterCell initCellWithTableView:tableView];
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
        MKSPPFilterCell *cell = [MKSPPFilterCell initCellWithTableView:tableView];
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

#pragma mark - MKNormalSliderCellDelegate
/// slider值发生改变的回调事件
/// @param value 当前slider的值
/// @param index 当前cell所在的index
- (void)mk_normalSliderValueChanged:(NSInteger)value index:(NSInteger)index {
    if (index == 0) {
        //Filter by RSSI
        self.dataModel.rssi = value;
        return;
    }
}

#pragma mark - MKSPPFilterCellDelegate
- (void)spp_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index {
    if (index == 0) {
        //Filter by PHY
        self.dataModel.filterByPHY = dataListIndex;
        MKSPPFilterCellModel *cellModel = self.section1List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 1) {
        //Filter Relationship
        self.dataModel.relationship = dataListIndex;
        MKSPPFilterCellModel *cellModel = self.section3List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
}

#pragma mark - cell event method
- (void)filterByMACAddress {
    MKSPPFilterByMacController *vc = [[MKSPPFilterByMacController alloc] init];
    vc.deviceModel = self.deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)filterByADVName {
    MKSPPFilterByAdvNameController *vc = [[MKSPPFilterByAdvNameController alloc] init];
    vc.deviceModel = self.deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)filterByRawData {
    MKSPPFilterByRawDataController *vc = [[MKSPPFilterByRawDataController alloc] init];
    vc.deviceModel = self.deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)duplicateDataFilter {
    MKSPPDuplicateDataFilterController *vc = [[MKSPPDuplicateDataFilterController alloc] init];
    vc.deviceModel = self.deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)uploadDataOption {
    MKSPPUploadDataOptionController *vc = [[MKSPPUploadDataOptionController alloc] init];
    vc.deviceModel = self.deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)configDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Setup succeed!"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSectionHeaderList];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalSliderCellModel *cellModel = [[MKNormalSliderCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = [MKCustomUIAdopter attributedString:@[@"Filter by RSSI ",@"(-127dBm~0dBm)"] fonts:@[MKFont(15.f),MKFont(13.f)] colors:@[DEFAULT_TEXT_COLOR,RGBCOLOR(223, 223, 223)]];
    cellModel.unit = @"dBm";
    cellModel.changed = YES;
    cellModel.sliderValue = self.dataModel.rssi;
    cellModel.leftNoteMsg = @"*The device will uplink valid ADV data with RSSI no less than";
    cellModel.contentColor = RGBCOLOR(242, 242, 242);
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKSPPFilterCellModel *cellModel = [[MKSPPFilterCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Filter by PHY";
    cellModel.dataListIndex = self.dataModel.filterByPHY;
    cellModel.dataList = @[@"1M PHY(V4.2)",@"1M PHY(V5.0)",@"1M PHY(V4.2) & 1M PHY(V5.0)",@"Coded PHY(V5.0)"];
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.showRightIcon = YES;
    cellModel1.leftMsg = @"Filter by MAC address";
    cellModel1.methodName = @"filterByMACAddress";
    [self.section2List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.showRightIcon = YES;
    cellModel2.leftMsg = @"Filter by ADV Name";
    cellModel2.methodName = @"filterByADVName";
    [self.section2List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.showRightIcon = YES;
    cellModel3.leftMsg = @"Filter by Raw Data";
    cellModel3.methodName = @"filterByRawData";
    [self.section2List addObject:cellModel3];
}

- (void)loadSection3Datas {
    MKSPPFilterCellModel *cellModel = [[MKSPPFilterCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Filter Relationship";
    cellModel.dataList = @[@"Null",@"Only MAC",@"Only ADV Name",@"Only RAW DATA",@"ADV name&Raw data",@"MAC&ADV name&Raw data",@"ADV name | Raw data"];
    cellModel.dataListIndex = self.dataModel.relationship;
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Duplicate Data Filter";
    cellModel.methodName = @"duplicateDataFilter";
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Upload Data Option";
    cellModel.methodName = @"uploadDataOption";
    [self.section5List addObject:cellModel];
}

- (void)loadSectionHeaderList {
    for (NSInteger i = 0; i < 6; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.sectionHeaderList addObject:headerModel];
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = self.deviceModel.deviceName;
    [self.rightButton setImage:LOADICON(@"MKScannerPro", @"MKSPPUploadOptionController", @"sp_saveIcon.png")
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

- (NSMutableArray *)sectionHeaderList {
    if (!_sectionHeaderList) {
        _sectionHeaderList = [NSMutableArray array];
    }
    return _sectionHeaderList;
}

- (MKSPPUploadOptionModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKSPPUploadOptionModel alloc] initWithDeviceID:self.deviceModel.deviceID
                                                           macAddress:self.deviceModel.macAddress
                                                                topic:[self.deviceModel currentSubscribedTopic]];
    }
    return _dataModel;
}

@end
