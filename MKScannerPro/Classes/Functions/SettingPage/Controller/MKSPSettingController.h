//
//  MKSPSettingController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/18.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@class MKSPDeviceModel;
@interface MKSPSettingController : MKBaseViewController

@property (nonatomic, strong)MKSPDeviceModel *deviceModel;

@end

NS_ASSUME_NONNULL_END