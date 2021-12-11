//
//  MKSPPMQTTManager.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPServerConfigDefines.h"

#import "MKSPPMQTTTaskID.h"

//The notification that is thrown when the connection status between the APP and the MQTT server changes.
extern NSString *const MKSPPMQTTSessionManagerStateChangedNotification;

//Notification of device online.
extern NSString *const MKSPPReceiveDeviceNetStateNotification;
//Notification of device OTA results.
extern NSString *const MKSPPReceiveDeviceOTAResultNotification;
//Notification of device reset to factory settings.
extern NSString *const MKSPPReceiveDeviceFactoryResetResultNotification;
//Notification that the device scans and reports Bluetooth data.
extern NSString *const MKSPPReceiveDeviceDatasNotification;
//Notification of SSL certificate download result
extern NSString *const MKSPPSSLCertificateDownloadResultsNotification;

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPMQTTManager : NSObject<MKSPServerManagerProtocol>

@property (nonatomic, assign, readonly)MKSPMQTTSessionManagerState state;

+ (MKSPPMQTTManager *)shared;

+ (void)singleDealloc;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentSubscribeTopic)NSString *subscribeTopic;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentPublishedTopic)NSString *publishedTopic;

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

/// Send Data
/// @param data json
/// @param topic topic,1-128 Characters
/// @param deviceID deviceID,1-32 Characters
/// @param taskID taskID
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        deviceID:(NSString *)deviceID
          taskID:(mk_spp_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
