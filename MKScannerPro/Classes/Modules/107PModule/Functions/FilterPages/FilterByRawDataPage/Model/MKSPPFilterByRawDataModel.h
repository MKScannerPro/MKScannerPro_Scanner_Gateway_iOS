//
//  MKSPPFilterByRawDataModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPFilterByRawDataModel : NSObject

@property (nonatomic, assign)BOOL iBeacon;

@property (nonatomic, assign)BOOL uid;

@property (nonatomic, assign)BOOL url;

@property (nonatomic, assign)BOOL tlm;

@property (nonatomic, assign)BOOL MKiBeacon;

@property (nonatomic, assign)BOOL MKiBeaconAcc;

@property (nonatomic, assign)BOOL bxpAcc;

@property (nonatomic, assign)BOOL bxpTH;

@property (nonatomic, assign)BOOL other;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
