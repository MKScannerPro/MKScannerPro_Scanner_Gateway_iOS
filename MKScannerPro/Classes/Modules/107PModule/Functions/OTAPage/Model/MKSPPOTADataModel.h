//
//  MKSPPOTADataModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Master Firmware
@interface MKSPPOTAMasterFirmwareModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *filePath;

@end


@interface MKSPPOTASlaveFirmware : NSObject

/// 从设备读取回来的从机mac地址
@property (nonatomic, copy)NSString *slaveMacAddress;

@property (nonatomic, copy)NSString *fileName;

@end


@interface MKSPPOTACACertificateModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *filePath;

@end


@interface MKSPPOTASelfSignedModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *caFilePath;

@property (nonatomic, copy)NSString *clientKeyPath;

@property (nonatomic, copy)NSString *clientCertPath;

@end


@interface MKSPPOTADataModel : NSObject

/// 当前用户选择的OTA类型.   0:Master Firmware      1:Slave Firmware      2:CA certificate     3:Self signed server certificates
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, strong, readonly)MKSPPOTAMasterFirmwareModel *masterModel;

@property (nonatomic, strong, readonly)MKSPPOTASlaveFirmware *slaveModel;

@property (nonatomic, strong, readonly)MKSPPOTACACertificateModel *caFileModel;

@property (nonatomic, strong, readonly)MKSPPOTASelfSignedModel *signedModel;

- (NSString *)checkParams;

@end

NS_ASSUME_NONNULL_END
