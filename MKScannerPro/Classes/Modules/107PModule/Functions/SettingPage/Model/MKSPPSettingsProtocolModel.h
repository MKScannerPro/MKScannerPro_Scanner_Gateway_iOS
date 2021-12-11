//
//  MKSPPSettingsProtocolModel.h
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

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPSettingsProtocolModel : NSObject<MKSPMQTTSettingForDevicePageProtocol,
MKSPLEDSettingPageProtocol,
MKSPDataReportPageProtocol,
MKSPNetworkStatusPageProtocol,
MKSPConnectionSettingPageProtocol>

@end

NS_ASSUME_NONNULL_END
