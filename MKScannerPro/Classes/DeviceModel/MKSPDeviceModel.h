//
//  MKSPDeviceModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKSPDeviceModelState) {
    MKSPDeviceModelStateOffline,
    MKSPDeviceModelStateOnline,
};

//当设备离线的时候发出通知
extern NSString *const MKSPDeviceModelOfflineNotification;

@protocol MKSPDeviceModelDelegate <NSObject>

/// 当前设备离线
/// @param deviceID 当前设备的deviceID
- (void)sp_deviceOfflineWithDeviceID:(NSString *)deviceID;

@end

@interface MKSPDeviceModel : NSObject

/**
 进行MQTT通信的时候，设备身份唯一识别码
 */
@property (nonatomic, copy)NSString *deviceID;

@property (nonatomic, copy)NSString *clientID;

/**
 设备广播名字
 */
@property (nonatomic, copy)NSString *deviceName;

/**
 订阅主题
 */
@property (nonatomic, copy)NSString *subscribedTopic;

/**
 发布主题
 */
@property (nonatomic, copy)NSString *publishedTopic;

/**
 mac地址
 */
@property (nonatomic, copy)NSString *macAddress;

/**
 设备的状态，离线、在线
 */
@property (nonatomic, assign)MKSPDeviceModelState onLineState;

#pragma mark - 业务流程相关

@property (nonatomic, weak)id <MKSPDeviceModelDelegate>delegate;

/**
 当前model的订阅主题，当用户设置了app的订阅主题时，返回设置的订阅主题，否则返回当前model的订阅主题
 
 @return subscribedTopic
 */
- (NSString *)currentSubscribedTopic;

/**
 当前model的发布主题，当用户设置了app的发布主题时，返回设置的发布主题，否则返回当前model的发布主题
 
 @return publishedTopic
 */
- (NSString *)currentPublishedTopic;

/**
 设备列表页面的状态监控
 */
- (void)startStateMonitoringTimer;

/**
 接收到开关状态的时候，需要清除离线状态计数
 */
- (void)resetTimerCounter;

/**
 取消定时器
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
