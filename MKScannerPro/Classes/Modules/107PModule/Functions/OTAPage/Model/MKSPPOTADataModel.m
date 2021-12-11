//
//  MKSPPOTADataModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPOTADataModel.h"
#import "MKMacroDefines.h"

@implementation MKSPPOTAMasterFirmwareModel
@end

@implementation MKSPPOTASlaveFirmware
@end

@implementation MKSPPOTACACertificateModel
@end

@implementation MKSPPOTASelfSignedModel
@end

@interface MKSPPOTADataModel ()

@property (nonatomic, strong)MKSPPOTAMasterFirmwareModel *masterModel;

@property (nonatomic, strong)MKSPPOTASlaveFirmware *slaveModel;

@property (nonatomic, strong)MKSPPOTACACertificateModel *caFileModel;

@property (nonatomic, strong)MKSPPOTASelfSignedModel *signedModel;

@end

@implementation MKSPPOTADataModel

- (NSString *)checkParams {
    if (self.type == 0) {
        //Master Firmware
        if (!ValidStr(self.masterModel.host) || self.masterModel.host.length > 64) {
            return @"Host error";
        }
        if (!ValidStr(self.masterModel.port) || [self.masterModel.port integerValue] < 0 || [self.masterModel.port integerValue] > 65535) {
            return @"Port error";
        }
        if (!ValidStr(self.masterModel.filePath) || self.masterModel.filePath.length > 100) {
            return @"File Path error";
        }
    }
    if (self.type == 1) {
        //Slave Firmware
        if (!ValidStr(self.slaveModel.fileName)) {
            return @"File error";
        }
    }
    if (self.type == 2) {
        //CA certificate
        if (!ValidStr(self.caFileModel.host) || self.caFileModel.host.length > 64) {
            return @"Host error";
        }
        if (!ValidStr(self.caFileModel.port) || [self.caFileModel.port integerValue] < 0 || [self.caFileModel.port integerValue] > 65535) {
            return @"Port error";
        }
        if (!ValidStr(self.caFileModel.filePath) || self.caFileModel.filePath.length > 100) {
            return @"File Path error";
        }
    }
    if (self.type == 3) {
        //Self signed server certificates
        if (!ValidStr(self.signedModel.host) || self.signedModel.host.length > 64) {
            return @"Host error";
        }
        if (!ValidStr(self.signedModel.port) || [self.signedModel.port integerValue] < 0 || [self.signedModel.port integerValue] > 65535) {
            return @"Port error";
        }
        if (!ValidStr(self.signedModel.caFilePath) || self.signedModel.caFilePath.length > 100) {
            return @"CA File Path error";
        }
        if (!ValidStr(self.signedModel.clientKeyPath) || self.signedModel.clientKeyPath.length > 100) {
            return @"Client Key file error";
        }
        if (!ValidStr(self.signedModel.clientCertPath) || self.signedModel.clientCertPath.length > 100) {
            return @"Client Cert file error";
        }
    }
    return @"";
}

#pragma mark - getter
- (MKSPPOTAMasterFirmwareModel *)masterModel {
    if (!_masterModel) {
        _masterModel = [[MKSPPOTAMasterFirmwareModel alloc] init];
    }
    return _masterModel;
}

- (MKSPPOTASlaveFirmware *)slaveModel {
    if (!_slaveModel) {
        _slaveModel = [[MKSPPOTASlaveFirmware alloc] init];
    }
    return _slaveModel;
}

- (MKSPPOTACACertificateModel *)caFileModel {
    if (!_caFileModel) {
        _caFileModel = [[MKSPPOTACACertificateModel alloc] init];
    }
    return _caFileModel;
}

- (MKSPPOTASelfSignedModel *)signedModel {
    if (!_signedModel) {
        _signedModel = [[MKSPPOTASelfSignedModel alloc] init];
    }
    return _signedModel;
}

@end
