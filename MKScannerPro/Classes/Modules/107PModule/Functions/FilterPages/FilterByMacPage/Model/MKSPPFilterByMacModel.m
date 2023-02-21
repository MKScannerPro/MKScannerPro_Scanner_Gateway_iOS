//
//  MKSPPFilterByMacModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPFilterByMacModel.h"

#import "MKMacroDefines.h"

#import "MKSPDeviceModeManager.h"

#import "MKSPPMQTTInterface.h"

@interface MKSPPFilterByMacModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSPPFilterByMacModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataList = @[];
    }
    return self;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterByMac]) {
            [self operationFailedBlockWithMsg:@"Read Datas Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithMacList:(NSArray <NSString *>*)macList
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configFilterByMac:macList]) {
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

- (BOOL)readFilterByMac {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByMacAddressWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.preciseMatch = ([returnData[@"data"][@"precise"] integerValue] == 1);
        self.reverseFilter = ([returnData[@"data"][@"reverse"] integerValue] == 1);
        if (ValidArray(returnData[@"data"][@"rule"])) {
            self.dataList = returnData[@"data"][@"rule"];
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByMac:(NSArray <NSString *>*)macList {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByMacAddress:macList preciseMatch:self.preciseMatch reverseFilter:self.reverseFilter deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterMacParams"
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
        _readQueue = dispatch_queue_create("filterMacQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
