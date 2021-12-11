//
//  MKSPMMQTTManager.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPMMQTTManager.h"

#import "MKMacroDefines.h"

#import "MKSPMQTTServerManager.h"

NSString *const MKSPMMQTTSessionManagerStateChangedNotification = @"MKSPMMQTTSessionManagerStateChangedNotification";

//相关通知
//设备上报的状态信息
NSString *const MKSPMReceiveDeviceNetStateNotification = @"MKSPMReceiveDeviceNetStateNotification";

static MKSPMMQTTManager *manager = nil;
static dispatch_once_t onceToken;

@implementation MKSPMMQTTManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKSPMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKSPMMQTTManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKSPMMQTTManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKSPMQTTServerManager shared] removeDataManager:self];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:MKSPMReceiveDeviceNetStateNotification
                                                        object:nil
                                                      userInfo:@{@"deviceID":deviceID}];
}

- (void)sp_didChangeState:(MKSPMQTTSessionManagerState)newState {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKSPMMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (NSString *)currentSubscribeTopic {
    return [MKSPMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKSPMQTTServerManager shared].serverParams.publishTopic;
}

- (BOOL)needConfigMQTTForApp {
    return !(ValidStr([MKSPMQTTServerManager shared].serverParams.host));
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

@end
