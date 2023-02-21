//
//  MKSPPFilterByOtherModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPFilterByOtherModel.h"

#import "MKMacroDefines.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKSPDeviceModeManager.h"

#import "MKSPPMQTTInterface.h"

@implementation MKSPPFilterRawAdvDataModel

- (BOOL)validParams {
    if (!ValidStr(self.dataType) || self.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.dataType]) {
        return NO;
    }
    NSArray *typeList = [self dataTypeList];
    if (![typeList containsObject:[self.dataType uppercaseString]]) {
        return NO;
    }
    if (self.minIndex == 0 && self.maxIndex == 0) {
        if (!ValidStr(self.rawData) || self.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.rawData] || (self.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (self.minIndex < 0 || self.minIndex > 29 || self.maxIndex < 0 || self.maxIndex > 29) {
        return NO;
    }
    
    if (self.maxIndex < self.minIndex) {
        return NO;
    }
    if (!ValidStr(self.rawData) || self.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.rawData]) {
        return NO;
    }
    NSInteger totalLen = (self.maxIndex - self.minIndex + 1) * 2;
    if (totalLen > 58 || self.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

- (NSArray *)dataTypeList {
    return @[@"01",@"02",@"03",@"04",@"05",
             @"06",@"07",@"08",@"09",@"0A",
             @"0D",@"0E",@"0F",@"10",@"11",
             @"12",@"14",@"15",@"16",@"17",
             @"18",@"19",@"1A",@"1B",@"1C",
             @"1D",@"1E",@"1F",@"20",@"21",
             @"22",@"23",@"24",@"25",@"26",
             @"27",@"28",@"29",@"2A",@"2B",
             @"2C",@"2D",@"3D",@"FF"];
}

@end


@interface MKSPPFilterByOtherModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSPPFilterByOtherModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterByOther]) {
            [self operationFailedBlockWithMsg:@"Read Filter Other Datas Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configWithRawDataList:(NSArray <MKSPPFilterRawAdvDataModel *>*)list
                 relationship:(mk_spp_filterByOther)relationship
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configFilterByOther:list relationship:relationship]) {
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
- (BOOL)readFilterByOther {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_readFilterByOtherDatasWithDeviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch"] integerValue] == 1);
        self.relationship = [returnData[@"data"][@"relationship"] integerValue];
        self.rawDataList = returnData[@"data"][@"rule"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByOther:(NSArray <MKSPPFilterRawAdvDataModel *>*)list relationship:(mk_spp_filterByOther)relationship {
    __block BOOL success = NO;
    [MKSPPMQTTInterface spp_configFilterByOtherDatas:self.isOn relationship:relationship rawDataList:list deviceID:[MKSPDeviceModeManager shared].deviceID macAddress:[MKSPDeviceModeManager shared].macAddress topic:[MKSPDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterOtherParams"
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
        _readQueue = dispatch_queue_create("filterOtherQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
