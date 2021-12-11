//
//  MKSPAMQTTInterface.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPAMQTTInterface.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKSPAMQTTManager.h"

@implementation MKSPAMQTTInterface

#pragma mark ****************************************参数读取************************************************

+ (void)spa_readDeviceInfoWithDeviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2003),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadDeviceInfoOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readDeviceUTCWithDeviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2004),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadDeviceUTCOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readIndicatorLightStatusWithDeviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2005),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadIndicatorLightStatusOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readNetworkStatusReportingIntervalWithDeviceID:(NSString *)deviceID
                                                macAddress:(NSString *)macAddress
                                                     topic:(NSString *)topic
                                                  sucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2006),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadNetworkStatusReportingIntervalOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readScanSwitchPramsWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2007),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadScanSwitchParamsOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readDataReportingTimeoutWithDeviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2008),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadDataReportingTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readUploadDataOptionWithDeviceID:(NSString *)deviceID
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2009),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadUploadDataOptionOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readDuplicateDataFilterWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2010),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadDuplicateDataFilterOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readBeaconTypeFilterDatasWithDeviceID:(NSString *)deviceID
                                       macAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2011),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadBeaconTypeFilterDatasOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readScanFilterConditionsWithDeviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2012),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadScanFilterConditionsOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readFilterConditions:(mk_spa_filterConditionsType)type
                        deviceID:(NSString *)deviceID
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":(type == mk_spa_filterConditionsTypeA) ? @(2013) : @(2014),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    mk_spa_serverOperationID operationID = (type == mk_spa_filterConditionsTypeA) ? mk_spa_server_taskReadFilterConditionsAOperation : mk_spa_server_taskReadFilterConditionsBOperation;
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:operationID
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readDeviceMQTTServerInfoWithDeviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2015),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadDeviceMQTTServerInfoOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readConnectionTimeoutWithDeviceID:(NSString *)deviceID
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2016),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadConnectionTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_readScanTimeoutOptionWithDeviceID:(NSString *)deviceID
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2017),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskReadScanTimeoutOptionOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

#pragma mark ****************************************参数配置************************************************

+ (void)spa_configDeviceResetWithDeviceID:(NSString *)deviceID
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1001),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"reset_state":@(1),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigDeviceResetOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configOTA:(mk_spa_otaType)type
                 host:(NSString *)host
                 port:(NSInteger)port
            catalogue:(NSString *)catalogue
             deviceID:(NSString *)deviceID
           macAddress:(NSString *)macAddress
                topic:(NSString *)topic
             sucBlock:(void (^)(id returnData))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(host) || host.length > 64 || ![host isAsciiString]
        || port < 0 || port > 65535
        || !ValidStr(catalogue) || catalogue.length > 100 || ![catalogue isAsciiString]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1002),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"file_type":[self fetchOTACmd:type],
                @"domain_name":host,
                @"port":@(port),
                @"file_way":catalogue,
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigDeviceOTAOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configDeviceTimeZone:(NSInteger)timeZone
                        deviceID:(NSString *)deviceID
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -12 || timeZone > 12) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1004),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"timestamp":@((long long)[[NSDate date] timeIntervalSince1970]),
                @"time_zone":@(timeZone),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigDeviceUTCOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configIndicatorLightStatus:(id <spa_indicatorLightStatusProtocol>)protocol
                              deviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (![protocol conformsToProtocol:@protocol(spa_indicatorLightStatusProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1005),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"ble_adv":(protocol.ble_advertising ? @(1) : @(0)),
                @"ble_connected":(protocol.ble_connected ? @(1) : @(0)),
                @"server_connecting":(protocol.wifi_connecting ? @(1) : @(0)),
                @"server_connected":(protocol.wifi_connected ? @(1) : @(0)),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigIndicatorLightStatusOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configNetworkStatusReportingInterval:(NSInteger)interval
                                        deviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || (interval > 0 && interval < 10) || interval > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1006),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"interval":@(interval),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigNetworkStatusReportingIntervalOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configScanSwitchStatus:(BOOL)isOn
                          scanTime:(NSInteger)scanTime
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (isOn && (scanTime < 1 || scanTime > 65535)) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1007),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"scan_switch":(isOn ? @(1) : @(0)),
                @"scan_time":@(scanTime),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigScanSwitchParamsOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configDataReportingTimeout:(NSInteger)interval
                              deviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 3000) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1008),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(interval),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigDataReportingTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configUploadDataOption:(id <spa_uploadDataOptionProtocol>)protocol
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (![protocol conformsToProtocol:@protocol(spa_uploadDataOptionProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1009),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"timestamp":(protocol.timestamp ? @(1) : @(0)),
                @"type":(protocol.deviceType ? @(1) : @(0)),
                @"rssi":(protocol.rssi ? @(1) : @(0)),
                @"raw":(protocol.rawData ? @(1) : @(0)),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigUploadDataOptionOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configDuplicateDataFilter:(mk_spa_duplicateDataFilter)filter
                               period:(long long)period
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (period < 1 || period > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1010),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"rule":@(filter),
                @"time":@(period),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigDuplicateDataFilterOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configBeaconTypeFilter:(id <spa_beaconTypeFilterProtocol>)protocol
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (![protocol conformsToProtocol:@protocol(spa_beaconTypeFilterProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1011),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"ibeacon":(protocol.iBeacon ? @(1) : @(0)),
                @"eddystone_uid":(protocol.uid ? @(1) : @(0)),
                @"eddystone_url":(protocol.url ? @(1) : @(0)),
                @"eddystone_tlm":(protocol.tlm ? @(1) : @(0)),
                @"MK_iBeacon":(protocol.MKiBeacon ? @(1) : @(0)),
                @"MK_ACC":(protocol.MKiBeaconACC ? @(1) : @(0)),
                @"BXP_ACC":(protocol.bxpAcc ? @(1) : @(0)),
                @"BXP_T&H":(protocol.bxpTH ? @(1) : @(0)),
                @"unknown":(protocol.unknown ? @(1) : @(0)),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigBeaconTypeFilterOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configScanFilterConditions:(mk_spa_scanFilterConditionShip)condition
                              deviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1012),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"relation":(condition == mk_spa_scanFilterConditionShipOR) ? @"OR" : @"AND",
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigScanFilterConditionsOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configFilterWithConditionsType:(mk_spa_filterConditionsType)type
                                conditions:(NSDictionary *)conditions
                                  deviceID:(NSString *)deviceID
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSDictionary *resultDic = [self filterConditions:conditions];
    if ([resultDic[@"code"] integerValue] == 0) {
        //存在错误
        [self operationFailedBlockWithMsg:resultDic[@"msg"] failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *params = resultDic[@"data"];
    NSDictionary *data = @{
        @"msg_id":(type == mk_spa_filterConditionsTypeA) ? @(1013) : @(1014),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":params,
    };
    mk_spa_serverOperationID operationID = (type == mk_spa_filterConditionsTypeA) ? mk_spa_server_taskConfigFilterConditionsAOperation : mk_spa_server_taskConfigFilterConditionsBOperation;
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:operationID
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configConnectionTimeout:(NSInteger)interval
                           deviceID:(NSString *)deviceID
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 1440) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1016),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(interval),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigConnectionTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_configScanTimeoutOption:(NSInteger)interval
                           deviceID:(NSString *)deviceID
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 1440) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1017),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(interval),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigScanTimeoutOptionOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spa_rebootDeviceWithDeviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1018),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"restart":@(1),
        }
    };
    [[MKSPAMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spa_server_taskConfigRebootDeviceOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

#pragma mark - private method
+ (NSString *)checkDeviceID:(NSString *)deviceID
                      topic:(NSString *)topic
                 macAddress:(NSString *)macAddress {
    if (!ValidStr(topic) || topic.length > 128 || ![topic isAsciiString]) {
        return @"Topic error";
    }
    if (!ValidStr(deviceID) || deviceID.length > 32 || ![deviceID isAsciiString]) {
        return @"ClientID error";
    }
    if (!ValidStr(macAddress)) {
        return @"Mac error";
    }
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@" " withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@":" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"-" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if (macAddress.length != 12 || ![macAddress regularExpressions:isHexadecimal]) {
        return @"Mac error";
    }
    return @"";
}

+ (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.SPAMQTTManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

+ (NSNumber *)fetchOTACmd:(mk_spa_otaType)type {
    switch (type) {
        case mk_spa_otaType_firmware:
            return @(0);
        case mk_spa_otaType_CACertificate:
            return @(1);
        case mk_spa_otaType_clientCertificate:
            return @(2);
        case mk_spa_otaType_privateKey:
            return @(3);
    }
}

+ (NSDictionary *)filterConditions:(NSDictionary *)conditions {
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    //总的扫描开关状态
    NSNumber *filterStatus = conditions[MKSPAFilterConditionsStatusKey];
    if (ValidNum(filterStatus)) {
        //存在总的扫描开关状态过滤
        NSInteger value = ([filterStatus boolValue] ? 1 : 0);
        [paramsDic setObject:@(value) forKey:@"rule_switch"];
    }
    //过滤的RSSI
    NSNumber *filterRssi = conditions[MKSPAFilterByRssiKey];
    if (ValidNum(filterRssi)) {
        //存在rssi过滤
        [paramsDic setObject:filterRssi forKey:@"rssi"];
    }
    NSDictionary *nameParams = conditions[MKSPAFilterByAdvNameKey];
    if (ValidDict(nameParams)) {
        //存在name过滤
        NSNumber *rules = nameParams[MKSPAFilterRulesKey];
        NSString *name = nameParams[@"name"];
        if (!ValidNum(rules) || [rules integerValue] < 0 || [rules integerValue] > 2) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Name Params Error",
            };
        }
        if ([rules integerValue] > 0 && (!ValidStr(name) || name.length > 10)) {
            //
            return @{
                @"code":@(0),
                @"msg":@"Filter By Name Params Error",
            };
        }
        NSDictionary *tempDic = @{
            @"flag":rules,
            @"rule":SafeStr(name)
        };
        [paramsDic setObject:tempDic forKey:@"name"];
    }
    NSDictionary *macParams = conditions[MKSPAFilterByDeviceMacKey];
    if (ValidDict(macParams)) {
        //存在mac过滤
        NSNumber *rules = macParams[MKSPAFilterRulesKey];
        NSString *mac = macParams[@"mac"];
        if (ValidStr(mac)) {
            mac = [mac stringByReplacingOccurrencesOfString:@":" withString:@""];
            mac = [mac stringByReplacingOccurrencesOfString:@"-" withString:@""];
            mac = [mac stringByReplacingOccurrencesOfString:@"_" withString:@""];
        }
        if (!ValidNum(rules) || [rules integerValue] < 0 || [rules integerValue] > 2) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Mac Params Error",
            };
        }
        if ([rules integerValue] > 0 && (![mac regularExpressions:isHexadecimal] || !ValidStr(mac) || mac.length > 12 || (mac.length % 2 != 0))) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Mac Params Error",
            };
        }
        NSDictionary *tempDic = @{
            @"flag":rules,
            @"rule":SafeStr(mac)
        };
        [paramsDic setObject:tempDic forKey:@"mac"];
    }
    NSDictionary *uuidParams = conditions[MKSPAFilterByiBeaconUUIDKey];
    if (ValidDict(uuidParams)) {
        //存在UUID过滤
        NSNumber *rules = uuidParams[MKSPAFilterRulesKey];
        NSString *uuid = uuidParams[@"uuid"];
        if (ValidStr(uuid)) {
            uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        if (!ValidNum(rules) || [rules integerValue] < 0 || [rules integerValue] > 2) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By UUID Params Error",
            };
        }
        if ([rules integerValue] > 0 && (![uuid regularExpressions:isHexadecimal] || !ValidStr(uuid) || uuid.length > 32 || (uuid.length % 2 != 0))) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By UUID Params Error",
            };
        }
        NSDictionary *tempDic = @{
            @"flag":rules,
            @"rule":SafeStr(uuid)
        };
        [paramsDic setObject:tempDic forKey:@"uuid"];
    }
    NSDictionary *majorParams = conditions[MKSPAFilterByiBeaconMajorKey];
    if (ValidDict(majorParams)) {
        //存在主值过滤
        NSNumber *rules = majorParams[MKSPAFilterRulesKey];
        NSNumber *maxNumber = majorParams[@"max"];
        NSNumber *minNumber = majorParams[@"min"];
        if (!ValidNum(rules) || [rules integerValue] < 0 || [rules integerValue] > 2) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Major Params Error",
            };
        }
        if ([rules integerValue] > 0 && (!ValidNum(minNumber) || [minNumber integerValue] < 0 || [minNumber integerValue] > 65535 || !ValidNum(maxNumber) || [maxNumber integerValue] < [minNumber integerValue] || [maxNumber integerValue] > 65535)) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Major Params Error",
            };
        }
        NSDictionary *tempDic = @{
            @"flag":rules,
            @"min":(ValidNum(minNumber) ? minNumber : @(0)),
            @"max":(ValidNum(maxNumber) ? maxNumber : @(0))
        };
        [paramsDic setObject:tempDic forKey:@"major"];
    }
    NSDictionary *minorParams = conditions[MKSPAFilterByiBeaconMinorKey];
    if (ValidDict(minorParams)) {
        //存在次值过滤
        NSNumber *rules = minorParams[MKSPAFilterRulesKey];
        NSNumber *maxNumber = minorParams[@"max"];
        NSNumber *minNumber = minorParams[@"min"];
        if (!ValidNum(rules) || [rules integerValue] < 0 || [rules integerValue] > 2) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Minor Params Error",
            };
        }
        if ([rules integerValue] > 0 && (!ValidNum(minNumber) || [minNumber integerValue] < 0 || [minNumber integerValue] > 65535 || !ValidNum(maxNumber) || [maxNumber integerValue] < [minNumber integerValue] || [maxNumber integerValue] > 65535)) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Minor Params Error",
            };
        }
        NSDictionary *tempDic = @{
            @"flag":rules,
            @"min":(ValidNum(minNumber) ? minNumber : @(0)),
            @"max":(ValidNum(maxNumber) ? maxNumber : @(0))
        };
        [paramsDic setObject:tempDic forKey:@"minor"];
    }
    NSDictionary *rawParams = conditions[MKSPAFilterByRawDataKey];
    if (ValidDict(rawParams)) {
        //存在原始数据过滤
        NSNumber *rules = rawParams[MKSPAFilterRulesKey];
        NSArray *dataList= rawParams[@"dataList"];
        if (!ValidNum(rules) || [rules integerValue] < 0 || [rules integerValue] > 2) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Raw Data Params Error",
            };
        }
        if ([rules integerValue] > 0 && (!ValidArray(dataList) || dataList.count > 5)) {
            return @{
                @"code":@(0),
                @"msg":@"Filter By Raw Data Params Error",
            };
        }
        NSMutableArray *tempDataList = [NSMutableArray array];
        for (NSInteger i = 0; i < dataList.count; i ++) {
            id <mk_spa_BLEFilterRawDataProtocol>protocol = dataList[i];
            if (![self isConfirmRawFilterProtocol:protocol]) {
                return @{
                    @"code":@(0),
                    @"msg":@"Filter By Raw Data Params Error",
                };
            }
            NSDictionary *tempDic = @{
                @"type":protocol.dataType,
                @"start":@(protocol.minIndex),
                @"end":@(protocol.maxIndex),
                @"data":protocol.rawData,
            };
            [tempDataList addObject:tempDic];
        }
        NSDictionary *tempDic = @{
            @"flag":rules,
            @"rule":tempDataList,
        };
        [paramsDic setObject:tempDic forKey:@"raw"];
    }
        
    return @{
        @"data":paramsDic,
        @"code":@(1)
    };
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_spa_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_spa_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![protocol.dataType regularExpressions:isHexadecimal]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!ValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![protocol.rawData regularExpressions:isHexadecimal] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 29 || protocol.maxIndex < 0 || protocol.maxIndex > 29) {
        return NO;
    }
    
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!ValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![protocol.rawData regularExpressions:isHexadecimal]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

@end
