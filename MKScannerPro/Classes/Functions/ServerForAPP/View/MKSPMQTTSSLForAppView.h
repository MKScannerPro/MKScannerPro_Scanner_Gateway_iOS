//
//  MKSPMQTTSSLForAppView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPMQTTSSLForAppViewModel : NSObject

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

@property (nonatomic, copy)NSString *clientFileName;

@end

@protocol MKSPMQTTSSLForAppViewDelegate <NSObject>

- (void)sp_mqtt_sslParams_app_sslStatusChanged:(BOOL)isOn;

/// 用户选择了加密方式
/// @param certificate 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
- (void)sp_mqtt_sslParams_app_certificateChanged:(NSInteger)certificate;

/// 用户点击选择了caFaile按钮
- (void)sp_mqtt_sslParams_app_caFilePressed;

/// 用户点击选择了cilentFile按钮
- (void)sp_mqtt_sslParams_app_clientFilePressed;

@end

@interface MKSPMQTTSSLForAppView : UIView

@property (nonatomic, strong)MKSPMQTTSSLForAppViewModel *dataModel;

@property (nonatomic, weak)id <MKSPMQTTSSLForAppViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END