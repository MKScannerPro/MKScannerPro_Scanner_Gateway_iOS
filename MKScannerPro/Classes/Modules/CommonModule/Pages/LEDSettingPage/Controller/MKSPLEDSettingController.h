//
//  MKSPLEDSettingController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPBaseViewController.h"

#import "MKSPLEDSettingPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPLEDSettingController : MKSPBaseViewController

@property (nonatomic, strong)id <MKSPLEDSettingPageProtocol>protocol;

@end

NS_ASSUME_NONNULL_END
