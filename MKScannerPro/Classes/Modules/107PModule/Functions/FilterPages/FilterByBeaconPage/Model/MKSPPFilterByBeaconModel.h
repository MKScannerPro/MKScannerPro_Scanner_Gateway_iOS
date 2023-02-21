//
//  MKSPPFilterByBeaconModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPPFilterByBeaconDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPFilterByBeaconModel : NSObject

- (instancetype)initWithPageType:(mk_spp_filterByBeaconPageType)pageType;

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *uuid;

@property (nonatomic, copy)NSString *minMajor;

@property (nonatomic, copy)NSString *maxMajor;

@property (nonatomic, copy)NSString *minMinor;

@property (nonatomic, copy)NSString *maxMinor;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
