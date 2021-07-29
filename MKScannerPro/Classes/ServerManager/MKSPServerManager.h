//
//  MKSPServerManager.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPServerTaskID.h"
#import "MKSPServerConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 相关通知

extern NSString *const MKSPMQTTSessionManagerStateChangedNotification;

//设备上报的状态信息
extern NSString *const MKSPReceiveDeviceNetStateNotification;
//设备OTA结果
extern NSString *const MKSPReceiveDeviceOTAResultNotification;
//设备恢复出厂设置
extern NSString *const MKSPReceiveDeviceFactoryResetResultNotification;
//设备扫描到的蓝牙数据
extern NSString *const MKSPReceiveDeviceDatasNotification;


typedef NS_ENUM(NSInteger, MKSPMQTTSessionManagerState) {
    MKSPMQTTSessionManagerStateStarting,
    MKSPMQTTSessionManagerStateConnecting,
    MKSPMQTTSessionManagerStateError,
    MKSPMQTTSessionManagerStateConnected,
    MKSPMQTTSessionManagerStateClosing,
    MKSPMQTTSessionManagerStateClosed
};

@interface MKSPServerManager : NSObject

@property (nonatomic, assign, readonly)MKSPMQTTSessionManagerState state;

/// 当前服务器参数
@property (nonatomic, strong, readonly)NSDictionary *serverParams;

+ (MKSPServerManager *)shared;

/// 将参数保存到本地，下次启动通过该参数连接服务器
/// @param protocol protocol
- (BOOL)saveServerParams:(id <MKSPServerDataProtocol>)protocol;

/**
 清除本地记录的设置信息
 */
- (BOOL)clearLocalData;

#pragma mark - *****************************服务器交互部分******************************

/// 开始连接服务器，前提是必须服务器参数不能为空
- (BOOL)connect;

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
          taskID:(mk_sp_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
