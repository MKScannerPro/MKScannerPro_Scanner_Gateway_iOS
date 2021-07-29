//
//  MKSPMQTTSettingForDeviceController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPMQTTSettingForDeviceController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"

#import "MKSPDeviceModel.h"

#import "MKSPServerInterface.h"

#import "MKSPMQTTSettingForDeviceCell.h"

@interface MKSPMQTTSettingForDeviceController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation MKSPMQTTSettingForDeviceController

- (void)dealloc {
    NSLog(@"MKSPMQTTSettingForDeviceController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKSPMQTTSettingForDeviceCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKSPMQTTSettingForDeviceCell *cell = [MKSPMQTTSettingForDeviceCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKSPServerInterface sp_readDeviceMQTTServerInfoWithDeviceID:self.deviceModel.deviceID
                                                      macAddress:self.deviceModel.macAddress
                                                           topic:[self.deviceModel currentSubscribedTopic]
                                                        sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self updateCellDatas:returnData[@"data"]];
    }
                                                     failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - updateCellDatas
- (void)updateCellDatas:(NSDictionary *)dic {
    MKSPMQTTSettingForDeviceCellModel *cellModel1 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel1.msg = @"Type";
    cellModel1.rightMsg = ([dic[@"connect_type"] integerValue] == 0) ? @"TCP" : @"SSL";
    [self.dataList addObject:cellModel1];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel2 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel2.msg = @"Host";
    cellModel2.rightMsg = dic[@"host"];
    [self.dataList addObject:cellModel2];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel3 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel3.msg = @"Port";
    cellModel3.rightMsg = [NSString stringWithFormat:@"%ld",(long)[dic[@"port"] integerValue]];
    [self.dataList addObject:cellModel3];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel4 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel4.msg = @"Clean session";
    cellModel4.rightMsg = ([dic[@"clean_session"] integerValue] == 1) ? @"YES" : @"NO";
    [self.dataList addObject:cellModel4];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel5 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel5.msg = @"Username";
    cellModel5.rightMsg = dic[@"username"];
    [self.dataList addObject:cellModel5];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel6 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel6.msg = @"Password";
    cellModel6.rightMsg = dic[@"password"];
    [self.dataList addObject:cellModel6];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel7 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel7.msg = @"Qos";
    cellModel7.rightMsg = [NSString stringWithFormat:@"%ld",(long)[dic[@"qos"] integerValue]];
    [self.dataList addObject:cellModel7];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel8 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel8.msg = @"Keep Alive";
    cellModel8.rightMsg = [NSString stringWithFormat:@"%ld",(long)[dic[@"keep_alive"] integerValue]];
    [self.dataList addObject:cellModel8];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel9 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel9.msg = @"Published Topic";
    cellModel9.rightMsg = dic[@"publish_topic"];
    [self.dataList addObject:cellModel9];
    
    MKSPMQTTSettingForDeviceCellModel *cellModel10 = [[MKSPMQTTSettingForDeviceCellModel alloc] init];
    cellModel10.msg = @"Subscribed Topic";
    cellModel10.rightMsg = dic[@"subscribe_topic"];
    [self.dataList addObject:cellModel10];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"MQTT settings for Device";
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

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
