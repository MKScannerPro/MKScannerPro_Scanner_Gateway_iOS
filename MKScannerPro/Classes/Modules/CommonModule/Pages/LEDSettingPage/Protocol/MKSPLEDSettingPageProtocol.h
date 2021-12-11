//
//  MKSPLEDSettingPageProtocol.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/12.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKSPLEDSettingPageProtocol <NSObject>

/// Read LED indicator status.
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress Mac address of the device
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sp_readIndicatorLightStatusWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure indicator status.
/// @param ble_advertising isOn
/// @param ble_connected isOn
/// @param server_connecting isOn
/// @param server_connected isOn
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress Mac address of the device
/// @param topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sp_configIndicatorLightStatus:(BOOL)ble_advertising
                        ble_connected:(BOOL)ble_connected
                    server_connecting:(BOOL)server_connecting
                     server_connected:(BOOL)server_connected
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
