//
//  MKSPOTAController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPOTAController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"
#import "MKTextFieldCell.h"
#import "MKTextButtonCell.h"

#import "MKSPDeviceModel.h"

#import "MKSPServerManager.h"
#import "MKSPServerInterface.h"

@interface MKSPOTADataModel : NSObject

/// 0 : Firmware      1: CA certificate  2 : Private key      3 : Client certificate
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *catalogue;

@end

@implementation MKSPOTADataModel
@end

@interface MKSPOTAController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)MKSPOTADataModel *dataModel;

@end

@implementation MKSPOTAController

- (void)dealloc {
    NSLog(@"MKSPOTAController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
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
    if (index == 0) {
        //Type
        MKTextButtonCellModel *cellModel = self.section0List[0];
        cellModel.dataListIndex = dataListIndex;
        self.dataModel.type = dataListIndex;
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    MKTextFieldCellModel *cellModel = self.section1List[index];
    cellModel.textFieldValue = value;
    if (index == 0) {
        //Host
        self.dataModel.host = value;
        return;
    }
    if (index == 1) {
        //Port
        self.dataModel.port = value;
        return;
    }
    if (index == 2) {
        //Catalogue
        self.dataModel.catalogue = value;
        return;
    }
}

#pragma mark - note
- (void)receiveOTAResult:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"device_id"])
        || ![self.deviceModel.deviceID isEqualToString:user[@"device_info"][@"device_id"]]) {
        return;
    }
    [[MKHudManager share] hide];
    NSInteger result = [user[@"data"][@"ota_result"] integerValue];
    if (result == 1) {
        [self.view showCentralToast:@"OTA Success!"];
        return;
    }
    [self.view showCentralToast:@"OTA Failed!"];
}

#pragma mark - event method
- (void)startButtonPressed {
    if (!ValidStr(self.dataModel.host) || self.dataModel.host.length > 64) {
        [self.view showCentralToast:@"Host error"];
        return;
    }
    if (!ValidStr(self.dataModel.port) || [self.dataModel.port integerValue] < 0 || [self.dataModel.port integerValue] > 65535) {
        [self.view showCentralToast:@"Port error"];
        return;
    }
    if (!ValidStr(self.dataModel.catalogue) || self.dataModel.catalogue.length > 100) {
        [self.view showCentralToast:@"Catalogue error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKSPServerInterface sp_configOTA:self.dataModel.type
                                 host:self.dataModel.host
                                 port:[self.dataModel.port integerValue]
                            catalogue:self.dataModel.catalogue
                             deviceID:self.deviceModel.deviceID
                           macAddress:self.deviceModel.macAddress
                                topic:[self.deviceModel currentSubscribedTopic]
                             sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveOTAResult:)
                                                     name:MKSPReceiveDeviceOTAResultNotification
                                                   object:nil];
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
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.msg = @"Type";
    cellModel.index = 0;
    cellModel.dataList = @[@"Firmware",@"CA certificate",@"Private key",@"Client certificate"];
    cellModel.dataListIndex = 0;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Host";
    cellModel1.textPlaceholder = @"1-64 Characters";
    cellModel1.textFieldType = mk_normal;
    cellModel1.maxLength = 64;
    [self.section1List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Port";
    cellModel2.textPlaceholder = @"0-65535";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.maxLength = 5;
    [self.section1List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Catalogue";
    cellModel3.textPlaceholder = @"1-100 Characters";
    cellModel3.textFieldType = mk_normal;
    cellModel3.maxLength = 100;
    [self.section1List addObject:cellModel3];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"OTA";
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

- (MKSPOTADataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKSPOTADataModel alloc] init];
    }
    return _dataModel;
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 100.f)];
    footerView.backgroundColor = COLOR_WHITE_MACROS;
    
    UIButton *startButton = [MKCustomUIAdopter customButtonWithTitle:@"Start Update"
                                                              target:self
                                                              action:@selector(startButtonPressed)];
    startButton.frame = CGRectMake(30.f, 30.f, kViewWidth - 2 * 30.f, 40.f);
    [footerView addSubview:startButton];
    
    return footerView;
}

@end
