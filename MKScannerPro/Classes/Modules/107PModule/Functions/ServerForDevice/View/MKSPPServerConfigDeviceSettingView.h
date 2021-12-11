//
//  MKSPPServerConfigDeviceSettingView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/14.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPServerConfigDeviceSettingViewModel : NSObject

@property (nonatomic, copy)NSString *deviceID;

/// 0-64 Characters
@property (nonatomic, copy)NSString *ntpHost;

/// -24~28
@property (nonatomic, assign)NSInteger timeZone;

@end

@protocol MKSPPServerConfigDeviceSettingViewDelegate <NSObject>

- (void)spp_mqtt_deviecSetting_deviceIDChanged:(NSString *)deviceID;

- (void)spp_mqtt_deviecSetting_ntpURLChanged:(NSString *)url;

- (void)spp_mqtt_deviecSetting_timeZoneChanged:(NSInteger)timeZone;

@end

@interface MKSPPServerConfigDeviceSettingView : UIView

@property (nonatomic, strong)MKSPPServerConfigDeviceSettingViewModel *dataModel;

@property (nonatomic, weak)id <MKSPPServerConfigDeviceSettingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
