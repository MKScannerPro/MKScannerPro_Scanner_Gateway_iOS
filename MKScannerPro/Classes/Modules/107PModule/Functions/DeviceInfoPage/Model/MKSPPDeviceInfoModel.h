//
//  MKSPPDeviceInfoModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/2.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPDeviceInfoModel : NSObject

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *productModel;

@property (nonatomic, copy)NSString *companyName;

@property (nonatomic, copy)NSString *hardwareVersion;

@property (nonatomic, copy)NSString *masterSoftwareVersion;

@property (nonatomic, copy)NSString *masterFirmwareVersion;

@property (nonatomic, copy)NSString *masterFirmwareName;

@property (nonatomic, copy)NSString *masterMac;

@property (nonatomic, copy)NSString *slaveSoftwareVersion;

@property (nonatomic, copy)NSString *slaveFirmwareVersion;

@property (nonatomic, copy)NSString *slaveMac;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
