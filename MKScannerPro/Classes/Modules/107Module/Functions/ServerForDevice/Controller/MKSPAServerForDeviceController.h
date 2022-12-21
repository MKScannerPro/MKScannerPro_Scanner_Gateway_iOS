//
//  MKSPAServerForDeviceController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPAServerForDeviceController : MKBaseViewController

/// MK110-AC347支持读取设备当前的各项MQTT参数
@property (nonatomic, assign)BOOL supportRead;

@end

NS_ASSUME_NONNULL_END
