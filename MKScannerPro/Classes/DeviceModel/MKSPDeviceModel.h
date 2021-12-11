//
//  MKSPDeviceModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/11.
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

/// 设备类型    00:MK107    02:MK107P
@property (nonatomic, copy)NSString *deviceType;

/**
 数据交互可能存在多个设备订阅同一个topic的情况，这个时候只能通过deviceID区分设备，所以统一为topic+deviceID来区分通信数据
 */
@property (nonatomic, copy)NSString *deviceID;

/// MTQQ通信所需的ID，如果存在重复的，会出现交替上线的情况
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
