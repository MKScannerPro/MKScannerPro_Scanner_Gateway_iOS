//
//  MKSPPMQTTInterface.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPMQTTInterface.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKSPPMQTTManager.h"

@implementation MKSPPMQTTInterface

#pragma mark ****************************************参数读取************************************************

+ (void)spp_readIndicatorLightStatusWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadIndicatorLightStatusOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readNetworkStatusReportingIntervalWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadNetworkStatusReportingIntervalOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readScanSwitchPramsWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadScanSwitchParamsOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readDataReportingTimeoutWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadDataReportingTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readDuplicateDataFilterWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadDuplicateDataFilterOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readDeviceMQTTServerInfoWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadDeviceMQTTServerInfoOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readConnectionTimeoutWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadConnectionTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readMasterDeviceInfoWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2019),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadMasterDeviceInfoOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readSlaveDeviceInfoWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2020),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadSlaveDeviceInfoOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readNTPServerWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2021),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadNTPServerOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readDeviceUTCWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2022),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadDeviceUTCOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readUploadDataOptionWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2024),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadUploadDataOptionOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterRelationshipWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2025),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterRelationshipOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByPHYWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2026),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByPHYOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByRSSIWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2027),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByRSSIOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByMacAddressWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2028),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByMacAddressOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByAdvNameWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2029),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByAdvNameOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByRawDataStatusWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2030),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByRawDataStatusOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByBeaconWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2031),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByBeaconOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByUIDWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2032),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByUIDOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByURLWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2033),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByURLOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByTLMWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2034),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByTLMOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByMKBeaconWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2035),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByMKBeaconOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByMKBeaconACCWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2036),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByMKBeaconACCOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_readFilterByOtherDatasWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(2039),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskReadFilterByOtherDatasOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

#pragma mark ****************************************参数配置************************************************

+ (void)spp_configDeviceResetWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigDeviceResetOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configIndicatorLightStatus:(id <spp_indicatorLightStatusProtocol>)protocol
                              deviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (![protocol conformsToProtocol:@protocol(spp_indicatorLightStatusProtocol)]) {
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigIndicatorLightStatusOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configNetworkStatusReportingInterval:(NSInteger)interval
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigNetworkStatusReportingIntervalOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configScanSwitchStatus:(BOOL)isOn
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigScanSwitchParamsOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configDataReportingTimeout:(NSInteger)interval
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigDataReportingTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configDuplicateDataFilter:(mk_spp_duplicateDataFilter)filter
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigDuplicateDataFilterOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configConnectionTimeout:(NSInteger)interval
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigConnectionTimeoutOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_rebootDeviceWithDeviceID:(NSString *)deviceID
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
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigRebootDeviceOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configNTPServer:(BOOL)isOn
                       host:(NSString *)host
                   deviceID:(NSString *)deviceID
                 macAddress:(NSString *)macAddress
                      topic:(NSString *)topic
                   sucBlock:(void (^)(id returnData))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (!host || ![host isKindOfClass:NSString.class] || host.length > 20) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1021),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"host":SafeStr(host),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigNTPServerOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configDeviceTimeZone:(NSInteger)timeZone
                        deviceID:(NSString *)deviceID
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -24 || timeZone > 28) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1022),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"timestamp":@((long long)[[NSDate date] timeIntervalSince1970]),
                @"timezone":@(timeZone),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigDeviceUTCOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configUploadDataOption:(id <spp_uploadDataOptionProtocol>)protocol
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (![protocol conformsToProtocol:@protocol(spp_uploadDataOptionProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1024),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"timestamp":(protocol.timestamp ? @(1) : @(0)),
                @"type":(protocol.deviceType ? @(1) : @(0)),
                @"rssi":(protocol.rssi ? @(1) : @(0)),
                @"adv":(protocol.rawData_advertising ? @(1) : @(0)),
                @"rsp":(protocol.rawData_response ? @(1) : @(0)),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigUploadDataOptionOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterRelationship:(mk_spp_filterRelationship)relationship
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
        @"msg_id":@(1025),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"rule":@(relationship),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterRelationshipOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByPHY:(mk_spp_PHYMode)mode
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
        @"msg_id":@(1026),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"phy":@(mode),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByPHYOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByRSSI:(NSInteger)rssi
                      deviceID:(NSString *)deviceID
                    macAddress:(NSString *)macAddress
                         topic:(NSString *)topic
                      sucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (rssi > 0 || rssi < -127) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1027),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
                @"rssi":@(rssi),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByRSSIOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByMacAddress:(NSArray <NSString *>*)macList
                        preciseMatch:(BOOL)preciseMatch
                       reverseFilter:(BOOL)reverseFilter
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
    if (!macList || ![macList isKindOfClass:NSArray.class] || macList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < macList.count; i ++) {
        NSString *tempString = macList[i];
        if (tempString.length < 2 || tempString.length > 12 || tempString.length % 2 != 0 || ![tempString regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1028),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"precise":(preciseMatch ? @(1) : @(0)),
            @"reverse":(reverseFilter ? @(1) : @(0)),
            @"array_num":@(macList.count),
            @"rule":macList,
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByMacAddressOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByADVName:(nonnull NSArray <NSString *>*)nameList
                     preciseMatch:(BOOL)preciseMatch
                    reverseFilter:(BOOL)reverseFilter
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
    if (!nameList || ![nameList isKindOfClass:NSArray.class] || nameList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < nameList.count; i ++) {
        NSString *tempString = nameList[i];
        if (!ValidStr(tempString) || tempString.length > 20 || ![tempString isAsciiString]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1029),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"precise":(preciseMatch ? @(1) : @(0)),
            @"reverse":(reverseFilter ? @(1) : @(0)),
            @"array_num":@(nameList.count),
            @"rule":nameList,
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByADVNameOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByBeacon:(BOOL)isOn
                        minMinor:(NSInteger)minMinor
                        maxMinor:(NSInteger)maxMinor
                        minMajor:(NSInteger)minMajor
                        maxMajor:(NSInteger)maxMajor
                            uuid:(NSString *)uuid
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
    if (minMinor < 0 || minMinor > 65535 || maxMinor < minMinor || maxMinor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMajor < 0 || minMajor > 65535 || maxMajor < minMajor || maxMajor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (!uuid || ![uuid isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(uuid)) {
        if (![uuid regularExpressions:isHexadecimal] || uuid.length > 32 || uuid.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1031),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"min_major":@(minMajor),
            @"max_major":@(maxMajor),
            @"min_minor":@(minMinor),
            @"max_minor":@(maxMinor),
            @"uuid":SafeStr(uuid),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByBeaconOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByUID:(BOOL)isOn
                  namespaceID:(NSString *)namespaceID
                   instanceID:(NSString *)instanceID
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
    if (!namespaceID || ![namespaceID isKindOfClass:NSString.class] || !instanceID || ![instanceID isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(namespaceID)) {
        if (![namespaceID regularExpressions:isHexadecimal] || namespaceID.length > 20 || namespaceID.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    if (ValidStr(instanceID)) {
        if (![instanceID regularExpressions:isHexadecimal] || instanceID.length > 12 || instanceID.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1032),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"namespace":SafeStr(namespaceID),
            @"instance":SafeStr(instanceID),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByUIDOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByURL:(BOOL)isOn
                          url:(NSString *)url
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
    if (!url || ![url isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(url)) {
        if (![url isAsciiString]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1033),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"url":SafeStr(url),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByURLOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByTLM:(BOOL)isOn
                          tlm:(mk_spp_filterByTLM)tlm
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
        @"msg_id":@(1034),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"version":@(tlm),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByTLMOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByMKBeacon:(BOOL)isOn
                          minMinor:(NSInteger)minMinor
                          maxMinor:(NSInteger)maxMinor
                          minMajor:(NSInteger)minMajor
                          maxMajor:(NSInteger)maxMajor
                              uuid:(NSString *)uuid
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
    if (minMinor < 0 || minMinor > 65535 || maxMinor < minMinor || maxMinor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMajor < 0 || minMajor > 65535 || maxMajor < minMajor || maxMajor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (!uuid || ![uuid isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(uuid)) {
        if (![uuid regularExpressions:isHexadecimal] || uuid.length > 32 || uuid.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1035),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"min_major":@(minMajor),
            @"max_major":@(maxMajor),
            @"min_minor":@(minMinor),
            @"max_minor":@(maxMinor),
            @"uuid":SafeStr(uuid),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByMKBeaconOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByMKBeaconACC:(BOOL)isOn
                             minMinor:(NSInteger)minMinor
                             maxMinor:(NSInteger)maxMinor
                             minMajor:(NSInteger)minMajor
                             maxMajor:(NSInteger)maxMajor
                                 uuid:(NSString *)uuid
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
    if (minMinor < 0 || minMinor > 65535 || maxMinor < minMinor || maxMinor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMajor < 0 || minMajor > 65535 || maxMajor < minMajor || maxMajor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (!uuid || ![uuid isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(uuid)) {
        if (![uuid regularExpressions:isHexadecimal] || uuid.length > 32 || uuid.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1036),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"min_major":@(minMajor),
            @"max_major":@(maxMajor),
            @"min_minor":@(minMinor),
            @"max_minor":@(maxMinor),
            @"uuid":SafeStr(uuid),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByMKBeaconACCOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterBXPACC:(BOOL)isOn
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
        @"msg_id":@(1037),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterBXPACCOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterBXPTH:(BOOL)isOn
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
        @"msg_id":@(1038),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterBXPTHOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configFilterByOtherDatas:(BOOL)isOn
                        relationship:(mk_spp_filterByOther)relationship
                         rawDataList:(NSArray <mk_spp_BLEFilterRawDataProtocol>*)rawDataList
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
    if (!rawDataList || ![rawDataList isKindOfClass:NSArray.class] || rawDataList.count > 3) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 1 && relationship != mk_spp_filterByOther_A) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 2 && relationship != mk_spp_filterByOther_AB && relationship != mk_spp_filterByOther_AOrB) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 3 && relationship != mk_spp_filterByOther_ABC && relationship != mk_spp_filterByOther_ABOrC && relationship != mk_spp_filterByOther_AOrBOrC) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSMutableArray *dicList = [NSMutableArray array];
    for (id <mk_spp_BLEFilterRawDataProtocol>protocol in rawDataList) {
        if (![self isConfirmRawFilterProtocol:protocol]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
        NSDictionary *dic = @{
            @"type":protocol.dataType,
            @"start":@(protocol.minIndex),
            @"end":@(protocol.maxIndex),
            @"data":protocol.rawData,
        };
        [dicList addObject:dic];
    }
    NSDictionary *data = @{
        @"msg_id":@(1039),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"switch":(isOn ? @(1) : @(0)),
            @"relationship":@(relationship),
            @"array_num":@(rawDataList.count),
            @"rule":dicList,
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigFilterByOtherDatasOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_reconnectNetworkWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(1040),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"reconnect":@(1)
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigReconnectNetworkOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_configMQTTServer:(id <spp_updateMQTTServerProtocol>)protocol
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
    if (![self checkMQTTServerProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1041),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"wifi_ssid":SafeStr(protocol.wifiSSID),
            @"wifi_passwd":SafeStr(protocol.wifiPassword),
            @"connect_mode":@(protocol.connect_mode),
            @"mqtt_host":SafeStr(protocol.mqtt_host),
            @"mqtt_port":@(protocol.mqtt_port),
            @"mqtt_username":SafeStr(protocol.mqtt_userName),
            @"mqtt_passwd":SafeStr(protocol.mqtt_password),
            @"clean_session":(protocol.cleanSession ? @(1) : @(0)),
            @"keep_alive":@(protocol.keepAlive),
            @"qos":@(protocol.qos),
            @"subscribe_topic":SafeStr(protocol.subscribeTopic),
            @"publish_topic":SafeStr(protocol.publishTopic),
            @"client_id":SafeStr(protocol.clientID),
            @"ssl_host":SafeStr(protocol.sslHost),
            @"ssl_port":@(protocol.sslPort),
            @"ca_way":SafeStr(protocol.caFilePath),
            @"client_cer_way":SafeStr(protocol.clientCertPath),
            @"client_key_way":SafeStr(protocol.clientKeyPath)
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigMQTTServerOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_updateSlaveFirmwareWithDeviceID:(NSString *)deviceID
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
        @"msg_id":@(1042),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{}
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigUpdateSlaveFirmwareOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_otaMasterFirmware:(NSString *)host
                         port:(NSInteger)port
                     filePath:(NSString *)filePath
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
    if (!ValidStr(host) || host.length > 64 || !ValidStr(filePath) || filePath.length > 100 || port < 0 || port > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1043),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"host":SafeStr(host),
            @"port":@(port),
            @"firmware_way":SafeStr(filePath),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigOTAMasterFirmwareOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_otaCACertificate:(NSString *)host
                        port:(NSInteger)port
                    filePath:(NSString *)filePath
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
    if (!ValidStr(host) || host.length > 64 || !ValidStr(filePath) || filePath.length > 100 || port < 0 || port > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1044),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"host":SafeStr(host),
            @"port":@(port),
            @"ca_way":SafeStr(filePath),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigCACertificateOperation
                               sucBlock:sucBlock
                            failedBlock:failedBlock];
}

+ (void)spp_otaSelfSignedCertificates:(NSString *)host
                                 port:(NSInteger)port
                           caFilePath:(NSString *)caFilePath
                        clientKeyPath:(NSString *)clientKeyPath
                       clientCertPath:(NSString *)clientCertPath
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
    if (!ValidStr(host) || host.length > 64 || !ValidStr(caFilePath) || caFilePath.length > 100 || port < 0 || port > 65535 || !ValidStr(clientKeyPath) || clientKeyPath.length > 100 || !ValidStr(clientCertPath) || clientCertPath.length > 100) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1045),
        @"device_info":@{
                @"device_id":deviceID,
                @"mac":macAddress
        },
        @"data":@{
            @"host":SafeStr(host),
            @"port":@(port),
            @"ca_way":SafeStr(caFilePath),
            @"client_cer_way":SafeStr(clientCertPath),
            @"client_key_way":SafeStr(clientKeyPath),
        }
    };
    [[MKSPPMQTTManager shared] sendData:data
                                  topic:topic
                               deviceID:deviceID
                                 taskID:mk_spp_server_taskConfigSelfSignedCertificatesOperation
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

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_spp_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_spp_BLEFilterRawDataProtocol)]) {
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

+ (BOOL)checkMQTTServerProtocol:(id <spp_updateMQTTServerProtocol>)protocol {
    if (!protocol || ![protocol conformsToProtocol:@protocol(spp_updateMQTTServerProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.mqtt_host) || protocol.mqtt_host.length > 64 || ![protocol.mqtt_host isAsciiString]) {
        return NO;
    }
    if (protocol.mqtt_port < 0 || protocol.mqtt_port > 65535) {
        return NO;
    }
    if (!ValidStr(protocol.clientID) || protocol.clientID.length > 64 || ![protocol.clientID isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.publishTopic) || protocol.publishTopic.length > 128 || ![protocol.publishTopic isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.subscribeTopic) || protocol.subscribeTopic.length > 128 || ![protocol.subscribeTopic isAsciiString]) {
        return NO;
    }
    if (protocol.qos < 0 || protocol.qos > 2) {
        return NO;
    }
    if (protocol.keepAlive < 10 || protocol.keepAlive > 120) {
        return NO;
    }
    if (protocol.mqtt_userName.length > 256 || (ValidStr(protocol.mqtt_userName) && ![protocol.mqtt_userName isAsciiString])) {
        return NO;
    }
    if (protocol.mqtt_password.length > 256 || (ValidStr(protocol.mqtt_password) && ![protocol.mqtt_password isAsciiString])) {
        return NO;
    }
    if (protocol.connect_mode < 0 || protocol.connect_mode > 3) {
        return NO;
    }
    if (protocol.connect_mode == 2 || protocol.connect_mode == 3) {
        if (!ValidStr(protocol.sslHost) || protocol.sslHost.length > 64) {
            return NO;
        }
        if (protocol.sslPort < 0 || protocol.sslPort > 65535) {
            return NO;
        }
        if (!ValidStr(protocol.caFilePath) || protocol.caFilePath.length > 100) {
            return NO;
        }
        if (protocol.connect_mode == 3 && (!ValidStr(protocol.clientKeyPath) || protocol.clientKeyPath.length > 100 || !ValidStr(protocol.clientCertPath) || protocol.clientCertPath.length > 100)) {
            return NO;
        }
    }
    if (!ValidStr(protocol.wifiSSID) || protocol.wifiSSID.length > 32 || ![protocol.wifiSSID isAsciiString]) {
        return NO;
    }
    if (protocol.wifiPassword.length > 64 || ![protocol.wifiPassword isAsciiString]) {
        return NO;
    }
    return YES;
}

@end
