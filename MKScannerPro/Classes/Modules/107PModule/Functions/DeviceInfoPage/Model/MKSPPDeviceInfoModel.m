//
//  MKSPPDeviceInfoModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/2.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPDeviceInfoModel.h"

#import "MKMacroDefines.h"

#import "MKSPPMQTTInterface.h"

@interface MKSPPDeviceInfoModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@property (nonatomic, copy)NSString *deviceID;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *topic;

@end

@implementation MKSPPDeviceInfoModel

- (instancetype)initWithDeviceID:(NSString *)deviceID
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic {
    if (self = [self init]) {
        self.deviceID = deviceID;
        self.macAddress = macAddress;
        self.topic = topic;
    }
    return self;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readMasterInfo]) {
            [self operationFailedBlockWithMsg:@"Read Master Device Info Error" block:failedBlock];
            return;
        }
        if (![self readSlaveInfo]) {
            [self operationFailedBlockWithMsg:@"Read Slave Device Info Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readMasterInfo {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readMasterDeviceInfoWithDeviceID:self.deviceID macAddress:self.macAddress topic:self.topic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.deviceName = returnData[@"data"][@"device_name"];
        self.productModel = returnData[@"data"][@"product_model"];
        self.companyName = returnData[@"data"][@"company_name"];
        self.hardwareVersion = returnData[@"data"][@"hardware_version"];
        self.masterSoftwareVersion = returnData[@"data"][@"software_version"];
        self.masterFirmwareVersion = returnData[@"data"][@"firmware_version"];
        self.masterFirmwareName = returnData[@"data"][@"firmware_name"];
        self.masterMac = returnData[@"data"][@"mac"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSlaveInfo {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readSlaveDeviceInfoWithDeviceID:self.deviceID macAddress:self.macAddress topic:self.topic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.slaveSoftwareVersion = returnData[@"data"][@"software_version"];
        self.slaveFirmwareVersion = returnData[@"data"][@"firmware_version"];
        self.slaveMac = returnData[@"data"][@"slave_mac"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"deviceInfoParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("deviceInfoQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
