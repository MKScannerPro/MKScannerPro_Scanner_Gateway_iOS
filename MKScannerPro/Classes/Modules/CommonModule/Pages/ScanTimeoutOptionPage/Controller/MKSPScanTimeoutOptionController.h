//
//  MKSPScanTimeoutOptionController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/8/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPBaseViewController.h"

#import "MKSPScanTimeoutOptionPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPScanTimeoutOptionController : MKSPBaseViewController

@property (nonatomic, strong)id <MKSPScanTimeoutOptionPageProtocol>protocol;

@end

NS_ASSUME_NONNULL_END
