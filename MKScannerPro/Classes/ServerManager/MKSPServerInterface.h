//
//  MKSPServerInterface.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPServerConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPServerInterface : NSObject

#pragma mark ****************************************参数读取************************************************

#pragma mark - 读取参数

/// 读取设备信息
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readDeviceInfoWithDeviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取设备UTC时间
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readDeviceUTCWithDeviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取LED指示灯状态
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readIndicatorLightStatusWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取设备联网状态上报间隔
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readNetworkStatusReportingIntervalWithDeviceID:(NSString *)deviceID
                                               macAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取扫描参数
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readScanSwitchPramsWithDeviceID:(NSString *)deviceID
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取扫描数据超时上报时间
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readDataReportingTimeoutWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取扫描数据上报内容选项
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readUploadDataOptionWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取扫描重复数据参数
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readDuplicateDataFilterWithDeviceID:(NSString *)deviceID
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取类型过滤选择
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readBeaconTypeFilterDatasWithDeviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取扫描过滤条件关系
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readScanFilterConditionsWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取扫描过滤条件
/// @param type A/B两种
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readFilterConditions:(mk_sp_filterConditionsType)type
                       deviceID:(NSString *)deviceID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取设备的MQTT服务器信息
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readDeviceMQTTServerInfoWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取网络连接超时时长
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_readConnectionTimeoutWithDeviceID:(NSString *)deviceID
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************参数配置************************************************

/// 设备恢复出厂设置
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configDeviceResetWithDeviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置设备OTA升级
/// @param type type
/// @param host 1-64 Characters
/// @param port 0~65535
/// @param catalogue 升级目录,1-100 Characters
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configOTA:(mk_sp_otaType)type
                host:(NSString *)host
                port:(NSInteger)port
           catalogue:(NSString *)catalogue
            deviceID:(NSString *)deviceID
          macAddress:(NSString *)macAddress
               topic:(NSString *)topic
            sucBlock:(void (^)(id returnData))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置设备的UTC时区，设备会按照该时区重新设置时间
/// @param timeZone -12~12
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configDeviceTimeZone:(NSInteger)timeZone
                       deviceID:(NSString *)deviceID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置指示灯状态
/// @param protocol protocol
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configIndicatorLightStatus:(id <sp_indicatorLightStatusProtocol>)protocol
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置设备联网状态上报间隔
/// @param interval If set to 0, it means that the report is closed.Range : 10s~86400s
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configNetworkStatusReportingInterval:(NSInteger)interval
                                       deviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置扫描参数
/// @param isOn 扫描开关是否打开
/// @param scanTime 扫描时长，1s~65535s
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configScanSwitchStatus:(BOOL)isOn
                         scanTime:(NSInteger)scanTime
                         deviceID:(NSString *)deviceID
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置扫描数据超时上报时间
/// @param interval 0ms~3000ms
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configDataReportingTimeout:(NSInteger)interval
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置扫描数据上报内容选项
/// @param protocol protocol
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configUploadDataOption:(id <sp_uploadDataOptionProtocol>)protocol
                         deviceID:(NSString *)deviceID
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置扫描重复数据参数
/// @param filter filter
/// @param period 1s~86400s
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configDuplicateDataFilter:(mk_sp_duplicateDataFilter)filter
                              period:(long long)period
                            deviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置类型过滤选择
/// @param protocol protocol
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configBeaconTypeFilter:(id <sp_beaconTypeFilterProtocol>)protocol
                         deviceID:(NSString *)deviceID
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置扫描过滤条件关系
/// @param condition OR/AND
/// @param interval 0ms~3000ms
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configScanFilterConditions:(mk_sp_scanFilterConditionShip)condition
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置扫描过滤条件
/// @param type A、B
/// @param conditions 过滤条件
/*

 1、设置扫描过滤条件是否生效
 MKSPFilterConditionsStatusKey:@(YES)       //打开过滤条件
 MKSPFilterConditionsStatusKey:@(NO)        //关闭过滤条件
 2、设置根据RSSI进行过滤(-127dBm~0dBm)
 MKSPFilterByRssiKey:@(-55)
 3、设置根据设备广播名称进行过滤,里面应该包含过滤的设备名称数据(1~10 Characters)、过滤的规则(mk_sp_filterRules枚举类型,目前有关闭过滤、正向过滤、反向过滤)
 MKSPFilterByAdvNameKey:@{
    MKSPFilterRulesKey:@(mk_sp_filterRules),
    @"name":@"xxxx"
 }
 4、设置根据设备的mac地址进行过滤，里面应该包含过滤的设备mac地址数据(1~6 HEX)、过滤的规则(mk_sp_filterRules枚举类型,目前有关闭过滤、正向过滤、反向过滤)
 MKSPFilterByDeviceMacKey:@{
    MKSPFilterRulesKey:@(mk_sp_filterRules),
    @"mac":@"xxxx"
 }
 5、设置根据iBeacon广播的UUID进行过滤,里面应该包含过滤的UUID数据(1~16 HEX)、过滤的规则(mk_sp_filterRules枚举类型,目前有关闭过滤、正向过滤、反向过滤)
 MKSPFilterByiBeaconUUIDKey:@{
    MKSPFilterRulesKey:@(mk_sp_filterRules),
    @"uuid":@"xxxx"
 }
 6、根据设置iBeacon的主值范围进行过滤，里面应该包含过滤的Major最小值(0~65535)、Major最大值(Major最小值~65535)、过滤的规则(mk_sp_filterRules枚举类型,目前有关闭过滤、正向过滤、反向过滤)
 MKSPFilterByiBeaconMajorKey:@{
    MKSPFilterRulesKey:@(mk_sp_filterRules),
    @"max":@(200),
    @"min":@(10)
 }
 7、根据设置iBeacon的次值范围进行过滤，里面应该包含过滤的Minor最小值(0~65535)、Minor最大值(Minor最小值~65535)、过滤的规则(mk_sp_filterRules枚举类型,目前有关闭过滤、正向过滤、反向过滤)
 MKSPFilterByiBeaconMinorKey:@{
    MKSPFilterRulesKey:@(mk_sp_filterRules),
    @"max":@(200),
    @"min":@(10)
 }
 8、根据设备广播的原始数据开始过滤，里面应该包含最多五组的原始数据(必须遵守mk_sp_BLEFilterRawDataProtocol协议)、过滤的规则(mk_sp_filterRules枚举类型,目前有关闭过滤、正向过滤、反向过滤)
 MKSPFilterByRawDataKey:@{
    MKSPFilterRulesKey:@(mk_sp_filterRules),
    dataList:@[
                id <mk_sp_BLEFilterRawDataProtocol>protocolModel1,
                id <mk_sp_BLEFilterRawDataProtocol>protocolModel2,
    ]
 }
 
 Note:以上所有规则都可以选填，需要设置的必须按照示例填写到json中不需要的不用填
 */
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configFilterWithConditionsType:(mk_sp_filterConditionsType)type
                               conditions:(NSDictionary *)conditions
                                 deviceID:(NSString *)deviceID
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置网络连接超时时长
/// @param interval 0min~1440mins.
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress mac地址
/// @param topic topic 1-128 Characters
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)sp_configConnectionTimeout:(NSInteger)interval
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
