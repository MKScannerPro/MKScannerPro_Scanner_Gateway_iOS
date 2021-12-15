//
//  Target_MKScannerPro_MK107P_Module.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_MKScannerPro_MK107P_Module : NSObject

/// 设备主页面
/// @param params @{@"deviceModel":id <MKSPDeviceModel *>deviceModel}
- (UIViewController *)Action_MKScannerPro_MK107PModule_DeviceDataPage:(NSDictionary *)params;

/// 设备MQTT参数页面
/// @param params @{}
- (UIViewController *)Action_MKScannerPro_MK107PModule_ServerForDevicePage:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
