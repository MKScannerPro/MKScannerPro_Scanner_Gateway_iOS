//
//  MKSPPMQTTManager.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPMQTTManager.h"

#import "MKMacroDefines.h"

#import "MKSPMQTTServerManager.h"

#import "MKSPPMQTTOperation.h"

NSString *const MKSPPMQTTSessionManagerStateChangedNotification = @"MKSPPMQTTSessionManagerStateChangedNotification";

//相关通知
//设备上报的状态信息
NSString *const MKSPPReceiveDeviceNetStateNotification = @"MKSPPReceiveDeviceNetStateNotification";
//设备OTA结果
NSString *const MKSPPReceiveDeviceOTAResultNotification = @"MKSPPReceiveDeviceOTAResultNotification";
//设备恢复出厂设置
NSString *const MKSPPReceiveDeviceFactoryResetResultNotification = @"MKSPPReceiveDeviceFactoryResetResultNotification";
//设备扫描到的蓝牙数据
NSString *const MKSPPReceiveDeviceDatasNotification = @"MKSPPReceiveDeviceDatasNotification";
//设备下载ssl证书结果
NSString *const MKSPPSSLCertificateDownloadResultsNotification = @"MKSPPSSLCertificateDownloadResultsNotification";

static MKSPPMQTTManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKSPPMQTTManager ()

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@end

@implementation MKSPPMQTTManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKSPMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKSPPMQTTManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKSPPMQTTManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKSPMQTTServerManager shared] removeDataManager:manager];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKSPServerManagerProtocol
- (void)sp_didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic {
    if (!ValidStr(topic) || !ValidDict(data)) {
        return;
    }
    NSInteger msgID = [data[@"msg_id"] integerValue];
    NSString *deviceID = data[@"device_info"][@"device_id"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKSPPReceiveDeviceNetStateNotification
                                                        object:nil
                                                      userInfo:@{@"deviceID":deviceID}];
    if (msgID == 3001) {
        //设备OTA结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPPReceiveDeviceOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3002) {
        //设备发布恢复出厂设置结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPPReceiveDeviceFactoryResetResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3003) {
        //设备在线状态，MKSPReceiveDeviceNetStateNotification已经抛出，所以不用处理
        return;
    }
    if (msgID == 3004) {
        //扫描到的数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPPReceiveDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3005) {
        //SSL证书下载结果上报
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPPSSLCertificateDownloadResultsNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    @synchronized(self.operationQueue) {
        NSArray *operations = [self.operationQueue.operations copy];
        for (NSOperation <MKSPPMQTTOperationProtocol>*operation in operations) {
            if (operation.executing) {
                [operation didReceiveMessage:data onTopic:topic];
                break;
            }
        }
    }
}

- (void)sp_didChangeState:(MKSPMQTTSessionManagerState)newState {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKSPPMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (NSString *)currentSubscribeTopic {
    return [MKSPMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKSPMQTTServerManager shared].serverParams.publishTopic;
}

- (id<MKSPServerParamsProtocol>)currentServerParams {
    return [MKSPMQTTServerManager shared].currentServerParams;
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKSPMQTTServerManager shared] subscriptions:topicList];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKSPMQTTServerManager shared] unsubscriptions:topicList];
}

- (MKSPMQTTSessionManagerState)state {
    return [MKSPMQTTServerManager shared].state;
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        deviceID:(NSString *)deviceID
          taskID:(mk_spp_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    
    MKSPPMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                                topic:topic
                                                             deviceID:deviceID
                                                                 data:data
                                                             sucBlock:sucBlock
                                                          failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    [self.operationQueue addOperation:operation];
}

#pragma mark - private method

- (MKSPPMQTTOperation *)generateOperationWithTaskID:(mk_spp_serverOperationID)taskID
                                              topic:(NSString *)topic
                                           deviceID:(NSString *)deviceID
                                               data:(NSDictionary *)data
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidDict(data)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Topic error" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(deviceID) || deviceID.length > 32) {
        [self operationFailedBlockWithMsg:@"ClientID error" failedBlock:failedBlock];
        return nil;
    }
    if ([MKMQTTServerManager shared].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKSPPMQTTOperation *operation = [[MKSPPMQTTOperation alloc] initOperationWithID:taskID deviceID:deviceID commandBlock:^{
        [[MKSPMQTTServerManager shared] sendData:data topic:topic sucBlock:nil failedBlock:nil];
    } completeBlock:^(NSError * _Nonnull error, id  _Nonnull returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            moko_dispatch_main_safe(^{
                if (failedBlock) {
                    failedBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
            return ;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock(returnData);
            }
        });
    }];
    return operation;
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.MKSPPMQTTManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

#pragma mark - getter
- (NSOperationQueue *)operationQueue{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

@end
