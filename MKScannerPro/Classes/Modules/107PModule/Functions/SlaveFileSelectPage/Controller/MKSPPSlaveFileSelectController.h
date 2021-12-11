//
//  MKSPPSlaveFileSelectController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKSPPSlaveFileSelectControllerDelegate <NSObject>

- (void)spp_slaveFileSelected:(NSString *)fileName;

@end

@interface MKSPPSlaveFileSelectController : MKSPBaseViewController

@property (nonatomic, weak)id <MKSPPSlaveFileSelectControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
