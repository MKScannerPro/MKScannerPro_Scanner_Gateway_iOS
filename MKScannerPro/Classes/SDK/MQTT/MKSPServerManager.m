//
//  MKSPServerManager.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPServerManager.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKNetworkManager.h"
#import "MKMQTTServerManager.h"

#import "MKSPServerOperation.h"

static MKSPServerManager *manager = nil;
static dispatch_once_t onceToken;

NSString *const MKSPMQTTSessionManagerStateChangedNotification = @"MKSPMQTTSessionManagerStateChangedNotification";

//相关通知
//设备上报的状态信息
NSString *const MKSPReceiveDeviceNetStateNotification = @"MKSPReceiveDeviceNetStateNotification";
//设备OTA结果
NSString *const MKSPReceiveDeviceOTAResultNotification = @"MKSPReceiveDeviceOTAResultNotification";
//设备恢复出厂设置
NSString *const MKSPReceiveDeviceFactoryResetResultNotification = @"MKSPReceiveDeviceFactoryResetResultNotification";
//设备扫描到的蓝牙数据
NSString *const MKSPReceiveDeviceDatasNotification = @"MKSPReceiveDeviceDatasNotification";

@interface MKSPServerManager ()

@property (nonatomic, assign)MKMQTTSessionManagerState state;

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@end

@implementation MKSPServerManager

- (void)dealloc{
    NSLog(@"销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init{
    if (self = [super init]) {
        [[MKMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKSPServerManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKSPServerManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKMQTTServerManager shared] removeDataManager:self];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKMQTTServerProtocol
/** gets called when a new message was received
 @param sessionManager the instance of MQTTSessionManager whose state changed
 @param data the data received, might be zero length
 @param topic the topic the data was published to
 @param retained indicates if the data retransmitted from server storage
 */
- (void)sessionManager:(MQTTSessionManager *)sessionManager
     didReceiveMessage:(NSData *)data
               onTopic:(NSString *)topic
              retained:(BOOL)retained {
    if (!ValidStr(topic) || !ValidData(data)) {
        return;
    }
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (!ValidDict(dataDic) || !ValidNum(dataDic[@"msg_id"]) || !ValidStr(dataDic[@"device_info"][@"device_id"])) {
        return;
    }
    NSInteger msgID = [dataDic[@"msg_id"] integerValue];
    NSString *deviceID = dataDic[@"device_info"][@"device_id"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKSPReceiveDeviceNetStateNotification
                                                        object:nil
                                                      userInfo:@{@"deviceID":deviceID}];
    if (msgID == 3001) {
        //设备OTA结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPReceiveDeviceOTAResultNotification
                                                            object:nil
                                                          userInfo:dataDic];
        return;
    }
    if (msgID == 3002) {
        //设备发布恢复出厂设置结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPReceiveDeviceFactoryResetResultNotification
                                                            object:nil
                                                          userInfo:dataDic];
        return;
    }
    if (msgID == 3003) {
        //设备在线状态，MKSPReceiveDeviceNetStateNotification已经抛出，所以不用处理
        return;
    }
    if (msgID == 3004) {
        //扫描到的数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPReceiveDeviceDatasNotification
                                                            object:nil
                                                          userInfo:dataDic];
        return;
    }
    @synchronized(self.operationQueue) {
        NSArray *operations = [self.operationQueue.operations copy];
        for (NSOperation <MKSPServerOperationProtocol>*operation in operations) {
            if (operation.executing) {
                [operation didReceiveMessage:dataDic onTopic:topic];
                break;
            }
        }
    }
}

/** gets called when the connection status changes
 @param sessionManager the instance of MQTTSessionManager whose state changed
 @param newState the new connection state of the sessionManager. This will be identical to `sessionManager.state`.
 */
- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MKMQTTSessionManagerState)newState {
    self.state = newState;
    [[NSNotificationCenter defaultCenter] postNotificationName:MKSPMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (void)connectTo:(NSString *)host
             port:(NSInteger)port
              tls:(BOOL)tls
        keepalive:(NSInteger)keepalive
            clean:(BOOL)clean
             auth:(BOOL)auth
             user:(NSString *)user
             pass:(NSString *)pass
             will:(BOOL)will
        willTopic:(NSString *)willTopic
          willMsg:(NSData *)willMsg
          willQos:(MQTTQosLevel)willQos
   willRetainFlag:(BOOL)willRetainFlag
     withClientId:(NSString *)clientId
   securityPolicy:(MQTTSSLSecurityPolicy *)securityPolicy
     certificates:(NSArray *)certificates
    protocolLevel:(MQTTProtocolVersion)protocolLevel
   connectHandler:(MQTTConnectHandler)connectHandler {
    [[MKMQTTServerManager shared] connectTo:host
                                       port:port
                                        tls:tls
                                  keepalive:keepalive
                                      clean:clean
                                       auth:auth
                                       user:user
                                       pass:pass
                                       will:will
                                  willTopic:willTopic
                                    willMsg:willMsg
                                    willQos:willQos
                             willRetainFlag:willRetainFlag
                               withClientId:clientId
                             securityPolicy:securityPolicy
                               certificates:certificates
                              protocolLevel:protocolLevel
                             connectHandler:connectHandler];
}

- (void)disconnect {
    [[MKMQTTServerManager shared] disconnect];
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKMQTTServerManager shared] subscriptions:topicList qosLevel:MQTTQosLevelAtLeastOnce];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKMQTTServerManager shared] unsubscriptions:topicList];
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        deviceID:(NSString *)deviceID
          taskID:(mk_sp_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    
    MKSPServerOperation *operation = [self generateOperationWithTaskID:taskID
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

- (MKSPServerOperation *)generateOperationWithTaskID:(mk_sp_serverOperationID)taskID
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
    MKSPServerOperation *operation = [[MKSPServerOperation alloc] initOperationWithID:taskID deviceID:deviceID commandBlock:^{
        [[MKMQTTServerManager shared] sendData:data topic:topic qosLevel:MQTTQosLevelAtLeastOnce sucBlock:nil failedBlock:nil];
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
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.SPServerManager"
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
