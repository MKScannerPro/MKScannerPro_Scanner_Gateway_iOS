//
//  MKSPPFilterByBeaconModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPFilterByBeaconModel.h"

#import "MKMacroDefines.h"

#import "MKSPDeviceModeManager.h"

#import "MKSPPMQTTInterface.h"

@interface MKSPPFilterByBeaconModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@property (nonatomic, assign)mk_spp_filterByBeaconPageType pageType;

@end

@implementation MKSPPFilterByBeaconModel

- (instancetype)initWithPageType:(mk_spp_filterByBeaconPageType)pageType {
    if (self = [self init]) {
        self.pageType = pageType;
    }
    return self;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (self.pageType == mk_spp_filterByBeaconPageType_beacon) {
            if (![self readFilterByBeacon]) {
                [self operationFailedBlockWithMsg:@"Read Filter iBeacon Error" block:failedBlock];
                return;
            }
        }else if (self.pageType == mk_spp_filterByBeaconPageType_MKBeacon) {
            if (![self readFilterByMKBeacon]) {
                [self operationFailedBlockWithMsg:@"Read Filter iBeacon Error" block:failedBlock];
                return;
            }
        }else if (self.pageType == mk_spp_filterByBeaconPageType_MKBeaconAcc) {
            if (![self readFilterByMKBeaconACC]) {
                [self operationFailedBlockWithMsg:@"Read Filter iBeacon Error" block:failedBlock];
                return;
            }
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (self.pageType == mk_spp_filterByBeaconPageType_beacon) {
            if (![self configFilterByBeacon]) {
                [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
                return;
            }
        }else if (self.pageType == mk_spp_filterByBeaconPageType_MKBeacon) {
            if (![self configFilterByMKBeacon]) {
                [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
                return;
            }
        }else if (self.pageType == mk_spp_filterByBeaconPageType_MKBeaconAcc) {
            if (![self configFilterByMKBeaconACC]) {
                [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readFilterByBeacon {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByBeaconWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch"] integerValue] == 1);
        self.minMinor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"min_minor"]];
        self.maxMinor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"max_minor"]];
        self.minMajor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"min_major"]];
        self.maxMajor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"max_major"]];
        self.uuid = [returnData[@"data"][@"uuid"] lowercaseString];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByBeacon {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByBeacon:self.isOn minMinor:[self.minMinor integerValue] maxMinor:[self.maxMinor integerValue] minMajor:[self.minMajor integerValue] maxMajor:[self.maxMajor integerValue] uuid:self.uuid deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterByMKBeacon {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByMKBeaconWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch"] integerValue] == 1);
        self.minMinor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"min_minor"]];
        self.maxMinor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"max_minor"]];
        self.minMajor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"min_major"]];
        self.maxMajor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"max_major"]];
        self.uuid = [returnData[@"data"][@"uuid"] lowercaseString];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByMKBeacon {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByMKBeacon:self.isOn minMinor:[self.minMinor integerValue] maxMinor:[self.maxMinor integerValue] minMajor:[self.minMajor integerValue] maxMajor:[self.maxMajor integerValue] uuid:self.uuid deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterByMKBeaconACC {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByMKBeaconACCWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch"] integerValue] == 1);
        self.minMinor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"min_minor"]];
        self.maxMinor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"max_minor"]];
        self.minMajor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"min_major"]];
        self.maxMajor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"max_major"]];
        self.uuid = [returnData[@"data"][@"uuid"] lowercaseString];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByMKBeaconACC {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByMKBeaconACC:self.isOn minMinor:[self.minMinor integerValue] maxMinor:[self.maxMinor integerValue] minMajor:[self.minMajor integerValue] maxMajor:[self.maxMajor integerValue] uuid:self.uuid deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterBeaconParams"
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
        _readQueue = dispatch_queue_create("filterBeaconQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
