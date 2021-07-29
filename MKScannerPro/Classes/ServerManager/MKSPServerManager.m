//
//  MKSPServerManager.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPServerManager.h"

#import "MQTTSSLSecurityPolicyTransport.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKSPMQTTServerManager.h"

#import "MKSPNetworkManager.h"

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


@interface NSObject (MKSPServerManager)

@end

@implementation NSObject (MKSPServerManager)

+ (void)load{
    [MKSPServerManager shared];
}

@end

@interface MKSPServerManager ()<MKMQTTServerManagerDelegate>

@property (nonatomic, copy)NSString *filePath;

@property (nonatomic, assign)MKSPMQTTSessionManagerState state;

@property (nonatomic, strong)NSDictionary *serverParams;

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@end

@implementation MKSPServerManager

- (void)dealloc{
    NSLog(@"销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init{
    if (self = [super init]) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.filePath = [documentPath stringByAppendingPathComponent:@"MKSPServerParams.txt"];
        self.serverParams = [[NSDictionary alloc] initWithContentsOfFile:self.filePath];
        if (!self.serverParams){
            self.serverParams = [NSDictionary dictionary];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:MKSPNetworkStatusChangedNotification
                                         object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:UIApplicationDidBecomeActiveNotification
                                         object:nil];
        [MKSPMQTTServerManager sharedInstance].delegate = self;
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

#pragma mark - MKMQTTServerManagerDelegate
- (void)mqttServerManagerStateChanged:(MKMQTTSessionManagerState)state {
    self.state = state;
    [[NSNotificationCenter defaultCenter] postNotificationName:MKSPMQTTSessionManagerStateChangedNotification object:nil];
}

- (void)sessionManager:(MKSPMQTTServerManager *)sessionManager didReceiveMessage:(NSData *)data onTopic:(NSString *)topic {
    if (!ValidStr(topic) || !ValidData(data)) {
        return;
    }
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (!ValidStr(receiveStr)) {
        return;
    }
    NSData * tempData = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    if (!ValidData(tempData)) {
        return;
    }
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingAllowFragments error:nil];
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

#pragma mark - note
- (void)networkStateChanged{
    if (![self paramsCanConnectServer]) {
        //服务器连接参数缺失
        return;
    }
    if (![[MKSPNetworkManager sharedInstance] currentNetworkAvailable]) {
        //如果是当前网络不可用，则断开当前手机与mqtt服务器的连接操作
        [[MKSPMQTTServerManager sharedInstance] disconnect];
        [self.operationQueue cancelAllOperations];
        self.state = MKSPMQTTSessionManagerStateStarting;
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPMQTTSessionManagerStateChangedNotification object:nil];
        return;
    }
    if ([MKSPMQTTServerManager sharedInstance].managerState == MKMQTTSessionManagerStateConnected
        || [MKSPMQTTServerManager sharedInstance].managerState == MKMQTTSessionManagerStateConnecting) {
        //已经连接或者正在连接，直接返回
        return;
    }
    //如果网络可用，则连接
    [self connect];
}

#pragma mark - public method

- (BOOL)saveServerParams:(id <MKSPServerDataProtocol>)protocol {
    if (![self checkServerDataProtocol:protocol]) {
        return NO;
    }
    self.serverParams = @{
        @"host":SafeStr(protocol.host),
        @"port":SafeStr(protocol.port),
        @"clientID":SafeStr(protocol.clientID),
        @"subscribeTopic":SafeStr(protocol.subscribeTopic),
        @"publishTopic":SafeStr(protocol.publishTopic),
        @"cleanSession":@(protocol.cleanSession),
        @"qos":@(protocol.qos),
        @"keepAlive":SafeStr(protocol.keepAlive),
        @"userName":SafeStr(protocol.userName),
        @"password":SafeStr(protocol.password),
        @"sslIsOn":@(protocol.sslIsOn),
        @"certificate":@(protocol.certificate),
        @"caFileName":SafeStr(protocol.caFileName),
        @"clientFileName":SafeStr(protocol.clientFileName),
    };
    
    return [self.serverParams writeToFile:self.filePath atomically:NO];
}

- (BOOL)clearLocalData {
    self.serverParams = @{};
    return [self.serverParams writeToFile:self.filePath atomically:NO];
}

#pragma mark - *****************************服务器交互部分******************************

- (BOOL)connect {
    if (![self paramsCanConnectServer]) {
        return NO;
    }
    [self.operationQueue cancelAllOperations];
    MQTTSSLSecurityPolicy *securityPolicy = nil;
    NSArray *certList = @[];
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    BOOL sslIsOn = [self.serverParams[@"sslIsOn"] boolValue];
    if (sslIsOn) {
        //需要ssl验证
        NSInteger certificate = [self.serverParams[@"certificate"] integerValue];
        if (certificate == 0) {
            //不需要CA根证书
            securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
        }
        if (certificate == 1 || certificate == 2) {
            //需要CA证书
            NSString *filePath = [document stringByAppendingPathComponent:self.serverParams[@"caFileName"]];
            NSData *clientCert = [NSData dataWithContentsOfFile:filePath];
            if (ValidData(clientCert)) {
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeCertificate];
                securityPolicy.pinnedCertificates = @[clientCert];
            }else {
                //未加载到CA证书
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
            }
        }
        if (certificate == 2) {
            //双向验证
            NSString *filePath = [document stringByAppendingPathComponent:self.serverParams[@"clientFileName"]];
            certList = [MQTTSSLSecurityPolicyTransport clientCertsFromP12:filePath passphrase:@"123456"];
        }
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        securityPolicy.validatesCertificateChain = NO;
    }
    [[MKSPMQTTServerManager sharedInstance] connectMQTTServer:self.serverParams[@"host"]
                                                         port:[self.serverParams[@"port"] integerValue]
                                                          tls:[self.serverParams[@"sslIsOn"] boolValue]
                                                    keepalive:[self.serverParams[@"keepAlive"] integerValue]
                                                        clean:[self.serverParams[@"cleanSession"] boolValue]
                                                         auth:YES
                                                         user:self.serverParams[@"userName"]
                                                         pass:self.serverParams[@"password"]
                                                     clientId:self.serverParams[@"clientID"]
                                               securityPolicy:securityPolicy
                                                 certificates:certList];
    return YES;
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKSPMQTTServerManager sharedInstance] subscriptions:topicList];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKSPMQTTServerManager sharedInstance] unsubscriptions:topicList];
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

- (BOOL)checkServerDataProtocol:(id <MKSPServerDataProtocol>)protocol {
    if (!ValidStr(protocol.host) || protocol.host.length > 64) {
        return NO;
    }
    if (!ValidStr(protocol.port) || [protocol.port integerValue] < 0 || [protocol.port integerValue] > 65535) {
        return NO;
    }
    if (!ValidStr(protocol.clientID) || protocol.clientID.length > 64) {
        return NO;
    }
    if (protocol.subscribeTopic.length > 128 || protocol.publishTopic.length > 128
        || protocol.userName.length > 256 || protocol.password.length > 256) {
        return NO;
    }
    if (protocol.qos < 0 || protocol.qos > 2) {
        return NO;
    }
    if (!ValidStr(protocol.keepAlive) || [protocol.keepAlive integerValue] < 10 || [protocol.keepAlive integerValue] > 120) {
        return NO;
    }
    if (protocol.certificate < 0 || protocol.certificate > 2) {
        return NO;
    }
    if (protocol.certificate == 1 && !ValidStr(protocol.caFileName)) {
        //需要根证书
        return NO;
    }
    if (protocol.certificate == 2 && (!ValidStr(protocol.caFileName) || !ValidStr(protocol.clientFileName))) {
        //双向验证，需要CA根证书、.p12证书
        return NO;
    }
    return YES;
}

- (BOOL)paramsCanConnectServer {
    if (!ValidDict(self.serverParams) || !ValidStr(self.serverParams[@"host"])
        || !ValidStr(self.serverParams[@"port"]) || !ValidStr(self.serverParams[@"keepAlive"]) || !ValidNum(self.serverParams[@"qos"]) || !ValidStr(self.serverParams[@"clientID"])) {
        return NO;
    }
    return YES;
}

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
    if ([MKSPMQTTServerManager sharedInstance].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKSPServerOperation *operation = [[MKSPServerOperation alloc] initOperationWithID:taskID deviceID:deviceID commandBlock:^{
        [[MKSPMQTTServerManager sharedInstance] sendData:data topic:topic sucBlock:nil failedBlock:nil];
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
