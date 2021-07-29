//
//  MKSPNetworkManager.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

//当前网络状态发生改变通知
extern NSString *const MKSPNetworkStatusChangedNotification;

@interface MKSPNetworkManager : NSObject

@property(nonatomic, assign, readonly)AFNetworkReachabilityStatus currentNetStatus;//当前网络状态

+ (MKSPNetworkManager *)sharedInstance;

/**
 获取当前手机连接的wifi ssid,注意:目前公司设备的ssid前两位为mk(MK)
 
 @return wifi ssid
 */
+ (NSString *)currentWifiSSID;

/**
 当前网络是否可用
 
 @return YES:可用，NO:不可用
 */
- (BOOL)currentNetworkAvailable;
/**
 当前网络是否是wifi
 
 @return YES:wifi，NO:非wifi
 */
- (BOOL)currentNetworkIsWifi;

@end

NS_ASSUME_NONNULL_END
