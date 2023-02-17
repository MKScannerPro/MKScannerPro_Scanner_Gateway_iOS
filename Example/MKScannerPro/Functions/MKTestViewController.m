//
//  MKTestViewController.m
//  MKScannerPro_Example
//
//  Created by aa on 2023/2/16.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKTestViewController.h"

#import "MKSPDeviceListController.h"

@interface MKTestViewController ()

@end

@implementation MKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultTitle = @"测试页面";
}

- (void)leftButtonMethod {
    MKSPDeviceListController *vc = [[MKSPDeviceListController alloc] init];
    vc.connectServer = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
