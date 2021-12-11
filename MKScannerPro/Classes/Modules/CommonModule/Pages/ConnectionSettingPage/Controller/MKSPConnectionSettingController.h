//
//  MKSPConnectionSettingController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/28.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPBaseViewController.h"

#import "MKSPConnectionSettingPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPConnectionSettingController : MKSPBaseViewController

@property (nonatomic, strong)id <MKSPConnectionSettingPageProtocol>protocol;

@end

NS_ASSUME_NONNULL_END
