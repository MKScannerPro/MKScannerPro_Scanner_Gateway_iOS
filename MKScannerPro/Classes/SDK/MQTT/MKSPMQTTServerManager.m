//
//  MKSPMQTTServerManager.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPMQTTServerManager.h"

#ifndef mk_sp_dispatch_main_safe
#define mk_sp_dispatch_main_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

static MKSPMQTTServerManager *manager = nil;
static dispatch_once_t onceToken;

@interface NSObject (MKSPMQTTServerManager)

@end

@implementation NSObject (MKSPMQTTServerManager)

+ (void)load{
    [MKSPMQTTServerManager sharedInstance];
}

@end

@interface MKSPMQTTServerManager()<MQTTSessionManagerDelegate>

@property (nonatomic, strong)MQTTSessionManager *sessionManager;

@property (nonatomic, assign)MKMQTTSessionManagerState managerState;

@property (nonatomic, strong)NSMutableDictionary *subscriptions;

@end

@implementation MKSPMQTTServerManager

+ (MKSPMQTTServerManager *)sharedInstance{
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKSPMQTTServerManager new];
        }
    });
    return manager;
}

#pragma mark - MQTTSessionManagerDelegate

- (void)sessionManager:(MQTTSessionManager *)sessionManager
     didReceiveMessage:(NSData *)data
               onTopic:(NSString *)topic
              retained:(BOOL)retained {
    if (sessionManager != self.sessionManager) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(sessionManager:didReceiveMessage:onTopic:)]) {
        mk_sp_dispatch_main_safe(^{[self.delegate sessionManager:manager didReceiveMessage:data onTopic:topic];});
    }
}

- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MQTTSessionManagerState)newState {
    //更新当前state
    self.managerState = [self fecthSessionState:newState];
    if ([self.delegate respondsToSelector:@selector(mqttServerManagerStateChanged:)]) {
        mk_sp_dispatch_main_safe(^{[self.delegate mqttServerManagerStateChanged:self.managerState];});
    }
    NSLog(@"连接状态发生改变:---%ld",(long)newState);
    if (self.managerState == MKMQTTSessionManagerStateConnected) {
        //连接成功了，订阅主题
        self.sessionManager.subscriptions = [NSDictionary dictionaryWithDictionary:self.subscriptions];
    }
    if (self.managerState == MKMQTTSessionManagerStateError) {
        //连接出错
        [self disconnect];
    }
}

#pragma mark - public method

- (void)connectMQTTServer:(NSString *)host
                     port:(NSInteger)port
                      tls:(BOOL)tls
                keepalive:(NSInteger)keepalive
                    clean:(BOOL)clean
                     auth:(BOOL)auth
                     user:(NSString *)user
                     pass:(NSString *)pass
                 clientId:(NSString *)clientId
           securityPolicy:(MQTTSSLSecurityPolicy *)securityPolicy
             certificates:(NSArray *)certificates {
    if (self.sessionManager) {
        self.sessionManager.delegate = nil;
        [self.sessionManager disconnectWithDisconnectHandler:nil];
        self.sessionManager = nil;
    }
    MQTTSessionManager *sessionManager = [[MQTTSessionManager alloc] init];
    sessionManager.delegate = self;
    self.sessionManager = sessionManager;
    [self.sessionManager connectTo:host
                              port:port
                               tls:tls
                         keepalive:keepalive
                             clean:clean
                              auth:auth
                              user:user
                              pass:pass
                              will:false
                         willTopic:nil
                           willMsg:nil
                           willQos:0
                    willRetainFlag:false
                      withClientId:clientId
                    securityPolicy:securityPolicy
                      certificates:certificates
                     protocolLevel:MQTTProtocolVersion311
                    connectHandler:nil];
}

/**
 断开连接
 */
- (void)disconnect {
    if (!self.sessionManager) {
        return;
    }
    self.sessionManager.delegate = nil;
    [self.sessionManager disconnectWithDisconnectHandler:nil];
    self.sessionManager = nil;
    self.managerState = MQTTSessionManagerStateStarting;
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    if (!topicList
        || topicList.count == 0
        || ![topicList isKindOfClass:NSArray.class]) {
        return;
    }
    @synchronized(self){
        for (NSString *topic in topicList) {
            if ([topic isKindOfClass:[NSString class]] && topic.length > 0) {
                [self.subscriptions setObject:@(MQTTQosLevelAtLeastOnce) forKey:topic];
            }
        }
        if (self.sessionManager && self.managerState == MQTTSessionManagerStateConnected) {
            //连接成功了，订阅主题
            self.sessionManager.subscriptions = [NSDictionary dictionaryWithDictionary:self.subscriptions];
        }
    }
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    if (!self.sessionManager
        || !topicList
        || topicList.count == 0
        || ![topicList isKindOfClass:NSArray.class]) {
        return;
    }
    @synchronized(self){
        NSMutableArray *removeTopicList = [NSMutableArray array];
        for (NSString *topic in topicList) {
            if ([topic isKindOfClass:[NSString class]] && topic.length > 0) {
                NSString *value = self.subscriptions[topic];
                if (value) {
                    [self.subscriptions removeObjectForKey:topic];
                    [removeTopicList addObject:topic];
                }
            }
        }
        if (removeTopicList.count == 0) {
            return;
        }
        self.sessionManager.subscriptions = [NSDictionary dictionaryWithDictionary:self.subscriptions];
        [self.sessionManager.session unsubscribeTopics:removeTopicList];
    }
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        sucBlock:(void (^)(void))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        [self operationFailedBlockWithMsg:@"Params error" block:failedBlock];
        return;
    }
    if (!topic || ![topic isKindOfClass:NSString.class] || topic.length == 0) {
        [self operationFailedBlockWithMsg:@"Topic error" block:failedBlock];
        return;
    }
    if (!self.sessionManager) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" block:failedBlock];
        return;
    }
    UInt16 msgid = [self.sessionManager sendData:[self dataWithJson:data] //要发送的消息体
                                           topic:topic //要往哪个topic发送消息
                                             qos:MQTTQosLevelAtLeastOnce //消息级别
                                          retain:false];
    if (msgid <= 0) {
        [self operationFailedBlockWithMsg:@"Send data error" block:failedBlock];
        return;
    }
    mk_sp_dispatch_main_safe(^{
        if (sucBlock) {
            sucBlock();
        }
    });
}

- (void)publishData:(NSData *)data
              topic:(NSString *)topic
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock {
    if (!data || ![data isKindOfClass:NSData.class]) {
        [self operationFailedBlockWithMsg:@"Params error" block:failedBlock];
        return;
    }
    if (!topic || ![topic isKindOfClass:NSString.class] || topic.length == 0) {
        [self operationFailedBlockWithMsg:@"Topic error" block:failedBlock];
        return;
    }
    if (!self.sessionManager) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" block:failedBlock];
        return;
    }
    UInt16 msgid = [self.sessionManager sendData:data   //要发送的消息体
                                           topic:topic //要往哪个topic发送消息
                                             qos:MQTTQosLevelAtLeastOnce //消息级别
                                          retain:false];
    if (msgid <= 0) {
        [self operationFailedBlockWithMsg:@"Send data error" block:failedBlock];
        return;
    }
    mk_sp_dispatch_main_safe(^{
        if (sucBlock) {
            sucBlock();
        }
    });
}

- (NSData *)dataWithJson:(NSDictionary *)dic {
    if (!dic || ![dic isKindOfClass:NSDictionary.class] || dic.allKeys.count == 0) {
        return [NSData data];
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        return [NSData data];
    }
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (!jsonString || jsonString.length == 0) {
        return [NSData data];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range];
    return [mutStr dataUsingEncoding:NSUTF8StringEncoding];
}

- (MKMQTTSessionManagerState)fecthSessionState:(MQTTSessionManagerState)orignState {
    switch (orignState) {
        case MQTTSessionManagerStateError:
            return MKMQTTSessionManagerStateError;
        case MQTTSessionManagerStateClosed:
            return MKMQTTSessionManagerStateClosed;
        case MQTTSessionManagerStateClosing:
            return MKMQTTSessionManagerStateClosing;
        case MQTTSessionManagerStateStarting:
            return MKMQTTSessionManagerStateStarting;
        case MQTTSessionManagerStateConnected:
            return MKMQTTSessionManagerStateConnected;
        case MQTTSessionManagerStateConnecting:
            return MKMQTTSessionManagerStateConnecting;
    }
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    mk_sp_dispatch_main_safe(^{
        if (block) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.moko.MKMQTTServerSDK"
                                                        code:-999
                                                    userInfo:@{@"errorInfo":msg}];
            block(error);
        }
    })
}

#pragma mark - setter & getter

- (NSMutableDictionary *)subscriptions {
    if (!_subscriptions) {
        _subscriptions = [NSMutableDictionary dictionary];
    }
    return _subscriptions;
}

@end
