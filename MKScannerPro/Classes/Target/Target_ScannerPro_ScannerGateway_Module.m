//
//  Target_ScannerPro_ScannerGateway_Module.m
//  MKScannerPro_Example
//
//  Created by aa on 2023/2/21.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "Target_ScannerPro_ScannerGateway_Module.h"

#import "MKSPDeviceListController.h"

@implementation Target_ScannerPro_ScannerGateway_Module

- (UIViewController *)Action_MKScannerPro_ScannerGateway_DeviceListPage:(NSDictionary *)params {
    MKSPDeviceListController *vc = [[MKSPDeviceListController alloc] init];
    vc.connectServer = YES;
    return vc;
}

@end
