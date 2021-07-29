//
//  MKSPServerConfigDeviceFooterView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/14.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPServerConfigDeviceFooterViewModel : NSObject

@property (nonatomic, assign)BOOL cleanSession;

@property (nonatomic, assign)NSInteger qos;

@property (nonatomic, copy)NSString *keepAlive;

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

@property (nonatomic, copy)NSString *clientKeyName;

@property (nonatomic, copy)NSString *clientCertName;

@property (nonatomic, copy)NSString *deviceID;

/// 0-64 Characters
@property (nonatomic, copy)NSString *ntpHost;

/// -12~12
@property (nonatomic, assign)NSInteger timeZone;

@end

@protocol MKSPServerConfigDeviceFooterViewDelegate <NSObject>

- (void)sp_mqtt_serverForDevice_cleanSessionStatusChanged:(BOOL)isOn;

- (void)sp_mqtt_serverForDevice_qosChanged:(NSInteger)qos;

- (void)sp_mqtt_serverForDevice_KeepAliveChanged:(NSString *)keepAlive;

- (void)sp_mqtt_serverForDevice_userNameChanged:(NSString *)userName;

- (void)sp_mqtt_serverForDevice_passwordChanged:(NSString *)password;

- (void)sp_mqtt_serverForDevice_sslStatusChanged:(BOOL)isOn;

/// 用户选择了加密方式
/// @param certificate 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
- (void)sp_mqtt_serverForDevice_certificateChanged:(NSInteger)certificate;

/// 用户点击选择了caFaile按钮
- (void)sp_mqtt_serverForDevice_caFilePressed;

/// 用户点击选择了cilentKeyFile按钮
- (void)sp_mqtt_serverForDevice_clientKeyPressed;

/// 用户点击选择了client cert file按钮
- (void)sp_mqtt_serverForDevice_clientCertPressed;

- (void)sp_mqtt_serverForDevice_deviceIDChanged:(NSString *)deviceID;

- (void)sp_mqtt_serverForDevice_ntpURLChanged:(NSString *)url;

/// 时区改变
/// @param timeZone -12~12
- (void)sp_mqtt_serverForDevice_timeZoneChanged:(NSInteger)timeZone;

@end

@interface MKSPServerConfigDeviceFooterView : UIView

@property (nonatomic, strong)MKSPServerConfigDeviceFooterViewModel *dataModel;

@property (nonatomic, weak)id <MKSPServerConfigDeviceFooterViewDelegate>delegate;

/// 动态刷新高度
/// @param isOn ssl开关是否打开
/// @param caFile 根证书名字
/// @param clientKeyName 客户端私钥名字
/// @param clientCertName 客户端证书
/// @param certificate 当前ssl加密规则
- (CGFloat)fetchHeightWithSSLStatus:(BOOL)isOn
                         CAFileName:(NSString *)caFile
                      clientKeyName:(NSString *)clientKeyName
                     clientCertName:(NSString *)clientCertName
                        certificate:(NSInteger)certificate;

@end

NS_ASSUME_NONNULL_END
