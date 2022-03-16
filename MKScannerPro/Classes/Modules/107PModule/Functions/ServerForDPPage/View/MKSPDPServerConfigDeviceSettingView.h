//
//  MKSPDPServerConfigDeviceSettingView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/14.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPDPServerConfigDeviceSettingViewModel : NSObject

@property (nonatomic, copy)NSString *deviceID;

/// 0-64 Characters
@property (nonatomic, copy)NSString *ntpHost;

/// -24~28
@property (nonatomic, assign)NSInteger timeZone;

/// 0~21
@property (nonatomic, assign)NSInteger domain;

@end

@protocol MKSPDPServerConfigDeviceSettingViewDelegate <NSObject>

- (void)spdp_mqtt_deviecSetting_deviceIDChanged:(NSString *)deviceID;

- (void)spdp_mqtt_deviecSetting_ntpURLChanged:(NSString *)url;

- (void)spdp_mqtt_deviecSetting_timeZoneChanged:(NSInteger)timeZone;

- (void)spdp_mqtt_deviecSetting_domainChanged:(NSInteger)domain;

@end

@interface MKSPDPServerConfigDeviceSettingView : UIView

@property (nonatomic, strong)MKSPDPServerConfigDeviceSettingViewModel *dataModel;

@property (nonatomic, weak)id <MKSPDPServerConfigDeviceSettingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
