//
//  MKSPPFilterByTLMModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/30.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPFilterByTLMModel.h"

#import "MKMacroDefines.h"

#import "MKSPPMQTTInterface.h"

@interface MKSPPFilterByTLMModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@property (nonatomic, copy)NSString *deviceID;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *topic;

@end

@implementation MKSPPFilterByTLMModel

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
        if (![self readFilterByTLM]) {
            [self operationFailedBlockWithMsg:@"Read Filter TLM Error" block:failedBlock];
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
        if (![self configFilterByTLM]) {
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
- (BOOL)readFilterByTLM {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByTLMWithDeviceID:self.deviceID macAddress:self.macAddress topic:self.topic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch"] integerValue] == 1);
        self.tlm = [returnData[@"data"][@"version"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByTLM {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByTLM:self.isOn tlm:self.tlm deviceID:self.deviceID macAddress:self.macAddress topic:self.topic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterTLMParams"
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
        _readQueue = dispatch_queue_create("filterTLMQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
