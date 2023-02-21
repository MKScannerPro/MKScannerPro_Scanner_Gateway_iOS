//
//  CTMediator+MKSPAdd.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@class MKSPDeviceModel;
@interface CTMediator (MKSPAdd)

/// 设备数据主页面
/// @param deviceType 设备类型
/*
    deviceType = 0 : mk107
    deviceType = 1 : mini-01
    deviceType = 2 : mk107Pro
    deviceType = 3 : mini-02
    deviceType = 4 : mk107D Pro
    deviceType = 5 : mini-03
    deviceType = 16 : MK110-AC347
 */
- (UIViewController *)CTMediator_MKScannerPro_DeviceDataPage:(NSInteger)deviceType;

/// 蓝牙配置MQTT服务器信息页面
/// @param deviceType 设备类型
/*
    deviceType = 0 : mk107
    deviceType = 1 : mini-01
    deviceType = 2 : mk107Pro
    deviceType = 3 : mini-02
    deviceType = 4 : mk107D Pro
    deviceType = 5 : mini-03
    deviceType = 16 : MK110-AC347
 */
- (UIViewController *)CTMediator_MKScannerPro_ServerForDevicePage:(NSInteger)deviceType;

@end

NS_ASSUME_NONNULL_END
