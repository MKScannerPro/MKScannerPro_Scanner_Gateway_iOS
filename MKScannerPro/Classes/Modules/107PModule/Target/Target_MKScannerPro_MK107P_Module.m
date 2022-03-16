//
//  Target_MKScannerPro_MK107P_Module.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_MKScannerPro_MK107P_Module.h"

#import "MKSPPDeviceDataController.h"

#import "MKSPPServerForDeviceController.h"
#import "MKSPDPServerForDeviceController.h"

@implementation Target_MKScannerPro_MK107P_Module

- (UIViewController *)Action_MKScannerPro_MK107PModule_DeviceDataPage:(NSDictionary *)params {
    MKSPPDeviceDataController *vc = [[MKSPPDeviceDataController alloc] init];
    vc.deviceModel = params[@"deviceModel"];
    return vc;
}

- (UIViewController *)Action_MKScannerPro_MK107PModule_ServerForDevicePage:(NSDictionary *)params {
    return [[MKSPPServerForDeviceController alloc] init];
}

- (UIViewController *)Action_MKScannerPro_MK107DPModule_ServerForDevicePage:(NSDictionary *)params {
    return [[MKSPDPServerForDeviceController alloc] init];
}

@end
