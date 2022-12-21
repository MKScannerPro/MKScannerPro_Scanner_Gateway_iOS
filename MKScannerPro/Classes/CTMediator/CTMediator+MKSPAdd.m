//
//  CTMediator+MKSPAdd.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CTMediator+MKSPAdd.h"

#import "MKScannerModuleKey.h"

#import "MKSPDeviceModel.h"

@implementation CTMediator (MKSPAdd)

- (UIViewController *)CTMediator_MKScannerPro_DeviceDataPage:(MKSPDeviceModel *)deviceModel {
    if ([deviceModel.deviceType isEqualToString:@"00"] || [deviceModel.deviceType isEqualToString:@"01"] || [deviceModel.deviceType isEqualToString:@"10"]) {
        //MK107、mini-01、MK110-AC347
        return [self Action_MKScannerProModule_ViewControllerWithTarget:kTarget_MKScannerPro_MK107_module
                                                                 action:kAction_MKScannerPro_MK107_deviceDataPage
                                                                 params:@{@"deviceModel":deviceModel}];
    }
    if ([deviceModel.deviceType isEqualToString:@"02"] || [deviceModel.deviceType isEqualToString:@"03"] || [deviceModel.deviceType isEqualToString:@"04"] || [deviceModel.deviceType isEqualToString:@"05"]) {
        //MK107Pro、mini-02、MK107D Pro
        return [self Action_MKScannerProModule_ViewControllerWithTarget:kTarget_MKScannerPro_MK107P_module
                                                                 action:kAction_MKScannerPro_MK107P_deviceDataPage
                                                                 params:@{@"deviceModel":deviceModel}];
    }
    return [[UIViewController alloc] init];
}

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
- (UIViewController *)CTMediator_MKScannerPro_ServerForDevicePage:(NSInteger)deviceType {
    if (deviceType == 0 || deviceType == 1 || deviceType == 16) {
        //MK107、mini-01、MK110-AC347
        return [self Action_MKScannerProModule_ViewControllerWithTarget:kTarget_MKScannerPro_MK107_module
                                                                 action:kAction_MKScannerPro_MK107_serverForDevicePage
                                                                 params:@{@"deviceType":@(deviceType)}];
    }
    if (deviceType == 2 || deviceType == 3) {
        //MK107Pro、mini-02
        return [self Action_MKScannerProModule_ViewControllerWithTarget:kTarget_MKScannerPro_MK107P_module
                                                                 action:kAction_MKScannerPro_MK107P_serverForDevicePage
                                                                 params:@{}];
    }
    if (deviceType == 4 || deviceType == 5) {
        //MK107D Pro、mini-03
        return [self Action_MKScannerProModule_ViewControllerWithTarget:kTarget_MKScannerPro_MK107P_module
                                                                 action:kAction_MKScannerPro_MK107DP_serverForDevicePage
                                                                 params:@{}];
    }
    return [[UIViewController alloc] init];
}

#pragma mark - private method
- (UIViewController *)Action_MKScannerProModule_ViewControllerWithTarget:(NSString *)targetName
                                                                  action:(NSString *)actionName
                                                                  params:(NSDictionary *)params{
    UIViewController *viewController = [self performTarget:targetName
                                                    action:actionName
                                                    params:params
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
