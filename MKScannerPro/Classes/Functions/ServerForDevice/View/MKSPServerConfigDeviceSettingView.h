//
//  MKSPServerConfigDeviceSettingView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/14.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPServerConfigDeviceSettingViewModel : NSObject

@property (nonatomic, copy)NSString *deviceID;

/// 0-64 Characters
@property (nonatomic, copy)NSString *ntpHost;

/// -12~12
@property (nonatomic, assign)NSInteger timeZone;

@end

@protocol MKSPServerConfigDeviceSettingViewDelegate <NSObject>

- (void)sp_mqtt_deviecSetting_deviceIDChanged:(NSString *)deviceID;

- (void)sp_mqtt_deviecSetting_ntpURLChanged:(NSString *)url;

- (void)sp_mqtt_deviecSetting_timeZoneChanged:(NSInteger)timeZone;

@end

@interface MKSPServerConfigDeviceSettingView : UIView

@property (nonatomic, strong)MKSPServerConfigDeviceSettingViewModel *dataModel;

@property (nonatomic, weak)id <MKSPServerConfigDeviceSettingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
