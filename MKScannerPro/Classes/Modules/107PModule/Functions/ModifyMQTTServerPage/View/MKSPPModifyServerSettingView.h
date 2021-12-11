//
//  MKSPPModifyServerSettingView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/6.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPModifyServerSettingViewModel : NSObject

/// wifi  ssid .1-32Characters.
@property (nonatomic, copy)NSString *ssid;

/// wifi password. 0-64 Characters.
@property (nonatomic, copy)NSString *password;

@end

@protocol MKSPPModifyServerSettingViewDelegate <NSObject>

- (void)spp_mqtt_modifyDevice_wifiSSIDChanged:(NSString *)ssid;

- (void)spp_mqtt_modifyDevice_wifiPasswordChanged:(NSString *)password;

@end

@interface MKSPPModifyServerSettingView : UIView

@property (nonatomic, strong)MKSPPModifyServerSettingViewModel *dataModel;

@property (nonatomic, weak)id <MKSPPModifyServerSettingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
