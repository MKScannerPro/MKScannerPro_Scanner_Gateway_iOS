//
//  MKSPPSettingsProtocolModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPSettingsProtocolModel.h"

#import "MKSPPMQTTInterface.h"

#import "MKSPPMQTTConfigDefines.h"

@interface MKSPPIndicatorLightStatusModel : NSObject<spp_indicatorLightStatusProtocol>

@property (nonatomic, assign)BOOL ble_advertising;

@property (nonatomic, assign)BOOL ble_connected;

@property (nonatomic, assign)BOOL wifi_connecting;

@property (nonatomic, assign)BOOL wifi_connected;

@end

@implementation MKSPPIndicatorLightStatusModel
@end

@implementation MKSPPSettingsProtocolModel

#pragma mark - MKSPMQTTSettingForDevicePageProtocol
- (void)sp_readDeviceMQTTServerInfoWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_readDeviceMQTTServerInfoWithDeviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

#pragma mark - MKSPLEDSettingPageProtocol
- (void)sp_readIndicatorLightStatusWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_readIndicatorLightStatusWithDeviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

- (void)sp_configIndicatorLightStatus:(BOOL)ble_advertising
                        ble_connected:(BOOL)ble_connected
                    server_connecting:(BOOL)server_connecting
                     server_connected:(BOOL)server_connected
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    MKSPPIndicatorLightStatusModel *dataModel = [[MKSPPIndicatorLightStatusModel alloc] init];
    dataModel.ble_advertising = ble_advertising;
    dataModel.ble_connected = ble_connected;
    dataModel.wifi_connecting = server_connecting;
    dataModel.wifi_connected = server_connected;
    
    [MKSPPMQTTInterface spp_configIndicatorLightStatus:dataModel
                                              deviceID:deviceID
                                            macAddress:macAddress
                                                 topic:topic
                                              sucBlock:sucBlock
                                           failedBlock:failedBlock];
}

#pragma mark - MKSPDataReportPageProtocol
- (void)sp_readDataReportingTimeoutWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_readDataReportingTimeoutWithDeviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

- (void)sp_configDataReportingTimeout:(NSInteger)interval
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_configDataReportingTimeout:interval
                                              deviceID:deviceID
                                            macAddress:macAddress
                                                 topic:topic
                                              sucBlock:sucBlock
                                           failedBlock:failedBlock];
}

#pragma mark - MKSPNetworkStatusPageProtocol
- (void)sp_readNetworkStatusReportingIntervalWithDeviceID:(NSString *)deviceID
                                               macAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_readNetworkStatusReportingIntervalWithDeviceID:deviceID
                                                                macAddress:macAddress
                                                                     topic:topic
                                                                  sucBlock:sucBlock
                                                               failedBlock:failedBlock];
}

- (void)sp_configNetworkStatusReportingInterval:(NSInteger)interval
                                       deviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_configNetworkStatusReportingInterval:interval
                                                        deviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

#pragma mark - MKSPConnectionSettingPageProtocol
- (void)sp_readConnectionTimeoutWithDeviceID:(NSString *)deviceID
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_readConnectionTimeoutWithDeviceID:deviceID
                                                   macAddress:macAddress
                                                        topic:topic
                                                     sucBlock:sucBlock
                                                  failedBlock:failedBlock];
}

- (void)sp_configConnectionTimeout:(NSInteger)interval
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [MKSPPMQTTInterface spp_configConnectionTimeout:interval
                                           deviceID:deviceID
                                         macAddress:macAddress
                                              topic:topic
                                           sucBlock:sucBlock
                                        failedBlock:failedBlock];
}

@end
