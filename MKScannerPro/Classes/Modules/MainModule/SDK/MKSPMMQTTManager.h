//
//  MKSPMMQTTManager.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPServerConfigDefines.h"

//The notification that is thrown when the connection status between the APP and the MQTT server changes.
extern NSString *const MKSPMMQTTSessionManagerStateChangedNotification;

//Notification of device online.
extern NSString *const MKSPMReceiveDeviceNetStateNotification;

NS_ASSUME_NONNULL_BEGIN

@interface MKSPMMQTTManager : NSObject<MKSPServerManagerProtocol>

@property (nonatomic, assign, readonly)MKSPMQTTSessionManagerState state;

+ (MKSPMMQTTManager *)shared;

+ (void)singleDealloc;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentSubscribeTopic)NSString *subscribeTopic;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentPublishedTopic)NSString *publishedTopic;

/// 本地如果没有app的MQTT信息，则需要引导用户设置
- (BOOL)needConfigMQTTForApp;

/**
 Subscribe the topic

 @param topicList topicList
 */
- (void)subscriptions:(NSArray <NSString *>*)topicList;

/**
 Unsubscribe the topic
 
 @param topicList topicList
 */
- (void)unsubscriptions:(NSArray <NSString *>*)topicList;

@end

NS_ASSUME_NONNULL_END
