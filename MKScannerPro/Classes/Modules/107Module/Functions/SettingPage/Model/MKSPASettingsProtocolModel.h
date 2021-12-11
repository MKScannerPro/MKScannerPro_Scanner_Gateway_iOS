//
//  MKSPASettingsProtocolModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPMQTTSettingForDevicePageProtocol.h"
#import "MKSPLEDSettingPageProtocol.h"
#import "MKSPDataReportPageProtocol.h"
#import "MKSPNetworkStatusPageProtocol.h"
#import "MKSPConnectionSettingPageProtocol.h"
#import "MKSPScanTimeoutOptionPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPASettingsProtocolModel : NSObject<MKSPMQTTSettingForDevicePageProtocol,
MKSPLEDSettingPageProtocol,
MKSPDataReportPageProtocol,
MKSPNetworkStatusPageProtocol,
MKSPConnectionSettingPageProtocol,
MKSPScanTimeoutOptionPageProtocol>

@end

NS_ASSUME_NONNULL_END
