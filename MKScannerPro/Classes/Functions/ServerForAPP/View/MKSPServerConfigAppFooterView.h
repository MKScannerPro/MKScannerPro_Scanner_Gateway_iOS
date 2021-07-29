//
//  MKSPServerConfigAppFooterView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPServerConfigAppFooterViewModel : NSObject

@property (nonatomic, assign)BOOL cleanSession;

@property (nonatomic, assign)NSInteger qos;

@property (nonatomic, copy)NSString *keepAlive;

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

@property (nonatomic, copy)NSString *clientFileName;

@end

@protocol MKSPServerConfigAppFooterViewDelegate <NSObject>

- (void)sp_mqtt_serverForApp_cleanSessionStatusChanged:(BOOL)isOn;

- (void)sp_mqtt_serverForApp_qosChanged:(NSInteger)qos;

- (void)sp_mqtt_serverForApp_KeepAliveChanged:(NSString *)keepAlive;

- (void)sp_mqtt_serverForApp_userNameChanged:(NSString *)userName;

- (void)sp_mqtt_serverForApp_passwordChanged:(NSString *)password;

- (void)sp_mqtt_serverForApp_sslStatusChanged:(BOOL)isOn;

/// 用户选择了加密方式
/// @param certificate 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
- (void)sp_mqtt_serverForApp_certificateChanged:(NSInteger)certificate;

/// 用户点击选择了caFaile按钮
- (void)sp_mqtt_serverForApp_caFilePressed;

/// 用户点击选择了cilentFile按钮
- (void)sp_mqtt_serverForApp_clientFilePressed;

@end

@interface MKSPServerConfigAppFooterView : UIView

@property (nonatomic, strong)MKSPServerConfigAppFooterViewModel *dataModel;

@property (nonatomic, weak)id <MKSPServerConfigAppFooterViewDelegate>delegate;

/// 动态刷新高度
/// @param isOn ssl开关是否打开
/// @param caFile 根证书名字
/// @param clientName 设备证书名字
/// @param certificate 当前ssl加密规则
- (CGFloat)fetchHeightWithSSLStatus:(BOOL)isOn
                         CAFileName:(NSString *)caFile
                         clientName:(NSString *)clientName
                        certificate:(NSInteger)certificate;

@end

NS_ASSUME_NONNULL_END
