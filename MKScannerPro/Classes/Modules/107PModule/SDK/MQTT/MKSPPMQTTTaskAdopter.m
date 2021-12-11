//
//  MKSPPMQTTTaskAdopter.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPMQTTTaskAdopter.h"

#import "MKMacroDefines.h"

#import "MKSPPMQTTTaskID.h"

@implementation MKSPPMQTTTaskAdopter

+ (NSDictionary *)parseDataWithJson:(NSDictionary *)json topic:(NSString *)topic {
    NSInteger msgID = [json[@"msg_id"] integerValue];
    if (msgID >= 1000 && msgID < 2000) {
        //配置指令
        return [self parseConfigParamsWithJson:json msgID:msgID topic:topic];
    }
    if (msgID >= 2000 && msgID < 3000) {
        //读取指令
        return [self parseReadParamsWithJson:json msgID:msgID topic:topic];
    }
    
    return @{};
}

#pragma mark - private method
+ (NSDictionary *)parseConfigParamsWithJson:(NSDictionary *)json msgID:(NSInteger)msgID topic:(NSString *)topic {
    BOOL success = ([json[@"result_code"] integerValue] == 0);
    if (!success) {
        return @{};
    }
    mk_spp_serverOperationID operationID = mk_spp_defaultServerOperationID;
    if (msgID == 1001) {
        //恢复出厂设置
        operationID = mk_spp_server_taskConfigDeviceResetOperation;
    }else if (msgID == 1005) {
        //配置LED指示灯状态
        operationID = mk_spp_server_taskConfigIndicatorLightStatusOperation;
    }else if (msgID == 1006) {
        //配置设备联网状态上报间隔
        operationID = mk_spp_server_taskConfigNetworkStatusReportingIntervalOperation;
    }else if (msgID == 1007) {
        //配置扫描参数
        operationID = mk_spp_server_taskConfigScanSwitchParamsOperation;
    }else if (msgID == 1008) {
        //配置扫描数据超时上报时间
        operationID = mk_spp_server_taskConfigDataReportingTimeoutOperation;
    }else if (msgID == 1010) {
        //配置扫描重复数据参数
        operationID = mk_spp_server_taskConfigDuplicateDataFilterOperation;
    }else if (msgID == 1016) {
        //配置网络连接超时时长
        operationID = mk_spp_server_taskConfigConnectionTimeoutOperation;
    }else if (msgID == 1018) {
        //设备重启
        operationID = mk_spp_server_taskConfigRebootDeviceOperation;
    }else if (msgID == 1021) {
        //设备NTP服务器
        operationID = mk_spp_server_taskConfigNTPServerOperation;
    }else if (msgID == 1022) {
        //配置UTC时间
        operationID = mk_spp_server_taskConfigDeviceUTCOperation;
    }else if (msgID == 1024) {
        //配置扫描数据上报内容选项
        operationID = mk_spp_server_taskConfigUploadDataOptionOperation;
    }else if (msgID == 1025) {
        //配置过滤逻辑
        operationID = mk_spp_server_taskConfigFilterRelationshipOperation;
    }else if (msgID == 1026) {
        //配置过滤PHY
        operationID = mk_spp_server_taskConfigFilterByPHYOperation;
    }else if (msgID == 1027) {
        //配置过滤RSSI
        operationID = mk_spp_server_taskConfigFilterByRSSIOperation;
    }else if (msgID == 1028) {
        //配置过滤mac
        operationID = mk_spp_server_taskConfigFilterByMacAddressOperation;
    }else if (msgID == 1029) {
        //配置过滤ADV Name
        operationID = mk_spp_server_taskConfigFilterByADVNameOperation;
    }else if (msgID == 1031) {
        //配置过滤iBeacon
        operationID = mk_spp_server_taskConfigFilterByBeaconOperation;
    }else if (msgID == 1032) {
        //配置过滤UID
        operationID = mk_spp_server_taskConfigFilterByUIDOperation;
    }else if (msgID == 1033) {
        //配置过滤URL
        operationID = mk_spp_server_taskConfigFilterByURLOperation;
    }else if (msgID == 1034) {
        //配置过滤TLM
        operationID = mk_spp_server_taskConfigFilterByTLMOperation;
    }else if (msgID == 1035) {
        //配置过滤MKiBeacon
        operationID = mk_spp_server_taskConfigFilterByMKBeaconOperation;
    }else if (msgID == 1036) {
        //配置过滤MKiBeacon&ACC
        operationID = mk_spp_server_taskConfigFilterByMKBeaconACCOperation;
    }else if (msgID == 1037) {
        //配置BeaconX Pro-ACC过滤状态
        operationID = mk_spp_server_taskConfigFilterBXPACCOperation;
    }else if (msgID == 1038) {
        //配置BeaconX Pro-T&H过滤状态
        operationID = mk_spp_server_taskConfigFilterBXPTHOperation;
    }else if (msgID == 1039) {
        //配置过滤Other数据
        operationID = mk_spp_server_taskConfigFilterByOtherDatasOperation;
    }else if (msgID == 1040) {
        //配置设备重入网
        operationID = mk_spp_server_taskConfigReconnectNetworkOperation;
    }else if (msgID == 1041) {
        //配置MQTT服务器信息
        operationID = mk_spp_server_taskConfigMQTTServerOperation;
    }else if (msgID == 1042) {
        //OTA升级从机固件
        operationID = mk_spp_server_taskConfigUpdateSlaveFirmwareOperation;
    }else if (msgID == 1043) {
        //OTA升级主机固件
        operationID = mk_spp_server_taskConfigOTAMasterFirmwareOperation;
    }else if (msgID == 1044) {
        //OTA升级CA证书
        operationID = mk_spp_server_taskConfigCACertificateOperation;
    }else if (msgID == 1045) {
        //OTA升级双向认证证书
        operationID = mk_spp_server_taskConfigSelfSignedCertificatesOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)parseReadParamsWithJson:(NSDictionary *)json msgID:(NSInteger)msgID topic:(NSString *)topic {
    mk_spp_serverOperationID operationID = mk_spp_defaultServerOperationID;
    if (msgID == 2001) {
        
    }else if (msgID == 2005) {
        //读取LED指示灯状态
        operationID = mk_spp_server_taskReadIndicatorLightStatusOperation;
    }else if (msgID == 2006) {
        //读取设备联网状态上报间隔
        operationID = mk_spp_server_taskReadNetworkStatusReportingIntervalOperation;
    }else if (msgID == 2007) {
        //读取扫描开关信息
        operationID = mk_spp_server_taskReadScanSwitchParamsOperation;
    }else if (msgID == 2008) {
        //读取扫描数据超时上报时间
        operationID = mk_spp_server_taskReadDataReportingTimeoutOperation;
    }else if (msgID == 2010) {
        //读取扫描重复数据参数
        operationID = mk_spp_server_taskReadDuplicateDataFilterOperation;
    }else if (msgID == 2015) {
        //读取设备的MQTT服务器信息
        operationID = mk_spp_server_taskReadDeviceMQTTServerInfoOperation;
    }else if (msgID == 2016) {
        //读取网络连接超时时长
        operationID = mk_spp_server_taskReadConnectionTimeoutOperation;
    }else if (msgID == 2019) {
        //读取主机设备信息
        operationID = mk_spp_server_taskReadMasterDeviceInfoOperation;
    }else if (msgID == 2020) {
        //读取从机设备信息
        operationID = mk_spp_server_taskReadSlaveDeviceInfoOperation;
    }else if (msgID == 2021) {
        //读取NTP服务器
        operationID = mk_spp_server_taskReadNTPServerOperation;
    }else if (msgID == 2022) {
        //读取UTC时间
        operationID = mk_spp_server_taskReadDeviceUTCOperation;
    }else if (msgID == 2024) {
        //读取扫描数据上报内容选项
        operationID = mk_spp_server_taskReadUploadDataOptionOperation;
    }else if (msgID == 2025) {
        //读取过滤逻辑
        operationID = mk_spp_server_taskReadFilterRelationshipOperation;
    }else if (msgID == 2026) {
        //读取PHY过滤
        operationID = mk_spp_server_taskReadFilterByPHYOperation;
    }else if (msgID == 2027) {
        //读取RSSI
        operationID = mk_spp_server_taskReadFilterByRSSIOperation;
    }else if (msgID == 2028) {
        //读取过滤mac
        operationID = mk_spp_server_taskReadFilterByMacAddressOperation;
    }else if (msgID == 2029) {
        //读取过滤ADV Name
        operationID = mk_spp_server_taskReadFilterByAdvNameOperation;
    }else if (msgID == 2030) {
        //读取过滤Raw 状态
        operationID = mk_spp_server_taskReadFilterByRawDataStatusOperation;
    }else if (msgID == 2031) {
        //读取过滤iBeacon
        operationID = mk_spp_server_taskReadFilterByBeaconOperation;
    }else if (msgID == 2032) {
        //读取过滤UID
        operationID = mk_spp_server_taskReadFilterByUIDOperation;
    }else if (msgID == 2033) {
        //读取过滤UTL
        operationID = mk_spp_server_taskReadFilterByURLOperation;
    }else if (msgID == 2034) {
        //读取过滤TLM
        operationID = mk_spp_server_taskReadFilterByTLMOperation;
    }else if (msgID == 2035) {
        //读取过滤MKiBeacon
        operationID = mk_spp_server_taskReadFilterByMKBeaconOperation;
    }else if (msgID == 2036) {
        //读取过滤MKiBeacon&ACC
        operationID = mk_spp_server_taskReadFilterByMKBeaconACCOperation;
    }else if (msgID == 2039) {
        //读取过滤Other数据
        operationID = mk_spp_server_taskReadFilterByOtherDatasOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_spp_serverOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
