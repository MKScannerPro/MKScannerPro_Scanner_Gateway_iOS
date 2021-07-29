//
//  MKSPMQTTGeneralParamsView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/12.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPMQTTGeneralParamsViewModel : NSObject

@property (nonatomic, assign)BOOL clean;

@property (nonatomic, assign)NSInteger qos;

@property (nonatomic, copy)NSString *keepAlive;

@end

@protocol MKSPMQTTGeneralParamsViewDelegate <NSObject>

- (void)sp_mqtt_generalParams_cleanSessionStatusChanged:(BOOL)isOn;

- (void)sp_mqtt_generalParams_qosChanged:(NSInteger)qos;

- (void)sp_mqtt_generalParams_KeepAliveChanged:(NSString *)keepAlive;

@end

@interface MKSPMQTTGeneralParamsView : UIView

@property (nonatomic, strong)MKSPMQTTGeneralParamsViewModel *dataModel;

@property (nonatomic, weak)id <MKSPMQTTGeneralParamsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
