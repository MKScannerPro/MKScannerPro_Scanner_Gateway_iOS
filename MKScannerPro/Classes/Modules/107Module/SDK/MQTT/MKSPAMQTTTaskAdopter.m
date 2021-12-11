//
//  MKSPAMQTTTaskAdopter.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPAMQTTTaskAdopter.h"

#import "MKMacroDefines.h"

#import "MKSPAMQTTTaskID.h"

@implementation MKSPAMQTTTaskAdopter

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
    mk_spa_serverOperationID operationID = mk_spa_defaultServerOperationID;
    if (msgID == 1001) {
        //恢复出厂设置
        operationID = mk_spa_server_taskConfigDeviceResetOperation;
    }else if (msgID == 1002) {
        //配置OTA时间
        operationID = mk_spa_server_taskConfigDeviceOTAOperation;
    }else if (msgID == 1004) {
        //配置UTC时间
        operationID = mk_spa_server_taskConfigDeviceUTCOperation;
    }else if (msgID == 1005) {
        //配置LED指示灯状态
        operationID = mk_spa_server_taskConfigIndicatorLightStatusOperation;
    }else if (msgID == 1006) {
        //配置设备联网状态上报间隔
        operationID = mk_spa_server_taskConfigNetworkStatusReportingIntervalOperation;
    }else if (msgID == 1007) {
        //配置扫描参数
        operationID = mk_spa_server_taskConfigScanSwitchParamsOperation;
    }else if (msgID == 1008) {
        //配置扫描数据超时上报时间
        operationID = mk_spa_server_taskConfigDataReportingTimeoutOperation;
    }else if (msgID == 1009) {
        //配置扫描数据上报内容选项
        operationID = mk_spa_server_taskConfigUploadDataOptionOperation;
    }else if (msgID == 1010) {
        //配置扫描重复数据参数
        operationID = mk_spa_server_taskConfigDuplicateDataFilterOperation;
    }else if (msgID == 1011) {
        //配置类型过滤选择
        operationID = mk_spa_server_taskConfigBeaconTypeFilterOperation;
    }else if (msgID == 1012) {
        //配置扫描过滤条件关系
        operationID = mk_spa_server_taskConfigScanFilterConditionsOperation;
    }else if (msgID == 1013) {
        //配置扫描过滤条件A
        operationID = mk_spa_server_taskConfigFilterConditionsAOperation;
    }else if (msgID == 1014) {
        //配置扫描过滤条件B
        operationID = mk_spa_server_taskConfigFilterConditionsBOperation;
    }else if (msgID == 1016) {
        //配置网络连接超时时长
        operationID = mk_spa_server_taskConfigConnectionTimeoutOperation;
    }else if (msgID == 1017) {
        //配置蓝牙扫描超时重启时长
        operationID = mk_spa_server_taskConfigScanTimeoutOptionOperation;
    }else if (msgID == 1018) {
        //设备重启
        operationID = mk_spa_server_taskConfigRebootDeviceOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)parseReadParamsWithJson:(NSDictionary *)json msgID:(NSInteger)msgID topic:(NSString *)topic {
    mk_spa_serverOperationID operationID = mk_spa_defaultServerOperationID;
    if (msgID == 2001) {
        
    }else if (msgID == 2003) {
        //读取设备信息
        operationID = mk_spa_server_taskReadDeviceInfoOperation;
    }else if (msgID == 2004) {
        //读取UTC时间
        operationID = mk_spa_server_taskReadDeviceUTCOperation;
    }else if (msgID == 2005) {
        //读取LED指示灯状态
        operationID = mk_spa_server_taskReadIndicatorLightStatusOperation;
    }else if (msgID == 2006) {
        //读取设备联网状态上报间隔
        operationID = mk_spa_server_taskReadNetworkStatusReportingIntervalOperation;
    }else if (msgID == 2007) {
        //读取扫描开关信息
        operationID = mk_spa_server_taskReadScanSwitchParamsOperation;
    }else if (msgID == 2008) {
        //读取扫描数据超时上报时间
        operationID = mk_spa_server_taskReadDataReportingTimeoutOperation;
    }else if (msgID == 2009) {
        //读取扫描数据上报内容选项
        operationID = mk_spa_server_taskReadUploadDataOptionOperation;
    }else if (msgID == 2010) {
        //读取扫描重复数据参数
        operationID = mk_spa_server_taskReadDuplicateDataFilterOperation;
    }else if (msgID == 2011) {
        //读取类型过滤选择
        operationID = mk_spa_server_taskReadBeaconTypeFilterDatasOperation;
    }else if (msgID == 2012) {
        //读取扫描过滤条件关系
        operationID = mk_spa_server_taskReadScanFilterConditionsOperation;
    }else if (msgID == 2013) {
        //读取扫描过滤条件A
        operationID = mk_spa_server_taskReadFilterConditionsAOperation;
    }else if (msgID == 2014) {
        //读取扫描过滤条件B
        operationID = mk_spa_server_taskReadFilterConditionsBOperation;
    }else if (msgID == 2015) {
        //读取设备的MQTT服务器信息
        operationID = mk_spa_server_taskReadDeviceMQTTServerInfoOperation;
    }else if (msgID == 2016) {
        //读取网络连接超时时长
        operationID = mk_spa_server_taskReadConnectionTimeoutOperation;
    }else if (msgID == 2017) {
        //读取蓝牙扫描超时重启时长
        operationID = mk_spa_server_taskReadScanTimeoutOptionOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_spa_serverOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
