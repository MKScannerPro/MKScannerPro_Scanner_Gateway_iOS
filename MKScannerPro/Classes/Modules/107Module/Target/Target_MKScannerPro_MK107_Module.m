//
//  Target_MKScannerPro_MK107_Module.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_MKScannerPro_MK107_Module.h"

#import "MKSPADeviceDataController.h"
#import "MKSPAServerForDeviceController.h"

@implementation Target_MKScannerPro_MK107_Module

- (UIViewController *)Action_MKScannerPro_MK107Module_DeviceDataPage:(NSDictionary *)params {
    MKSPADeviceDataController *vc = [[MKSPADeviceDataController alloc] init];
    vc.deviceModel = params[@"deviceModel"];
    return vc;
}

- (UIViewController *)Action_MKScannerPro_MK107Module_ServerForDevicePage:(NSDictionary *)params {
    return [[MKSPAServerForDeviceController alloc] init];
}

@end
