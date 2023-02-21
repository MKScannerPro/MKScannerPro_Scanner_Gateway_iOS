//
//  MKSPPUploadOptionModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPUploadOptionModel.h"

#import "MKMacroDefines.h"

#import "MKSPDeviceModeManager.h"

#import "MKSPPMQTTInterface.h"

@interface MKSPPUploadOptionModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSPPUploadOptionModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Read Filter Relationship Error" block:failedBlock];
            return;
        }
        if (![self readFilterByPHY]) {
            [self operationFailedBlockWithMsg:@"Read Filter By PHY Error" block:failedBlock];
            return;
        }
        if (![self readFilterByRSSI]) {
            [self operationFailedBlockWithMsg:@"Read Filter By RSSI Error" block:failedBlock];
            return;
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
        if (![self configFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
            return;
        }
        if (![self configFilterByPHY]) {
            [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
            return;
        }
        if (![self configFilterByRSSI]) {
            [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
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
- (BOOL)readFilterRelationship {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterRelationshipWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.relationship = [returnData[@"data"][@"rule"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRelationship {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterRelationship:self.relationship deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterByPHY {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByPHYWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.filterByPHY = [returnData[@"data"][@"phy"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByPHY {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByPHY:self.filterByPHY deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterByRSSI {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByRSSIWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rssi = [returnData[@"data"][@"rssi"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByRSSI {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByRSSI:self.rssi deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterParams"
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
        _readQueue = dispatch_queue_create("filterQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
