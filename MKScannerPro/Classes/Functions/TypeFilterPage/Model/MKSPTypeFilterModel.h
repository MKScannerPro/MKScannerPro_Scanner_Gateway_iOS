//
//  MKSPTypeFilterModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPServerConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPTypeFilterModel : NSObject<sp_beaconTypeFilterProtocol>

@property (nonatomic, assign)BOOL iBeacon;

@property (nonatomic, assign)BOOL uid;

@property (nonatomic, assign)BOOL url;

@property (nonatomic, assign)BOOL tlm;

@property (nonatomic, assign)BOOL MKiBeacon;

@property (nonatomic, assign)BOOL MKiBeaconACC;

@property (nonatomic, assign)BOOL bxpAcc;

@property (nonatomic, assign)BOOL bxpTH;

@property (nonatomic, assign)BOOL unknown;

@end

NS_ASSUME_NONNULL_END
