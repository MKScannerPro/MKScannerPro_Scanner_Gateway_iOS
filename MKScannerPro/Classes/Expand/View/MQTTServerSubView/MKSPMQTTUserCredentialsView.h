//
//  MKSPMQTTUserCredentialsView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/12.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPMQTTUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@protocol MKSPMQTTUserCredentialsViewDelegate <NSObject>

- (void)sp_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)sp_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKSPMQTTUserCredentialsView : UIView

@property (nonatomic, strong)MKSPMQTTUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKSPMQTTUserCredentialsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
