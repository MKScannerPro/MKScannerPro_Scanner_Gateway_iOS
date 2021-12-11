

typedef NS_ENUM(NSInteger, mk_spp_serverOperationID) {
    mk_spp_defaultServerOperationID,
    
#pragma mark - 读取
    mk_spp_server_taskReadIndicatorLightStatusOperation,     //读取LED指示灯状态
    mk_spp_server_taskReadNetworkStatusReportingIntervalOperation,   //读取设备联网状态上报间隔
    mk_spp_server_taskReadScanSwitchParamsOperation,         //读取扫描开关信息
    mk_spp_server_taskReadDataReportingTimeoutOperation,     //读取扫描数据超时上报时间
    mk_spp_server_taskReadDuplicateDataFilterOperation,      //读取扫描重复数据参数
    mk_spp_server_taskReadDeviceMQTTServerInfoOperation,     //读取设备的MQTT服务器信息
    mk_spp_server_taskReadConnectionTimeoutOperation,        //读取网络连接超时时长
    mk_spp_server_taskReadMasterDeviceInfoOperation,             //读取主机模块设备信息
    mk_spp_server_taskReadSlaveDeviceInfoOperation,              //读取从机模块设备信息
    mk_spp_server_taskReadNTPServerOperation,               //读取NTP服务器信息
    mk_spp_server_taskReadDeviceUTCOperation,                //读取UTC时间
    mk_spp_server_taskReadUploadDataOptionOperation,         //读取扫描数据上报内容选项
    mk_spp_server_taskReadFilterRelationshipOperation,       //读取过滤逻辑
    mk_spp_server_taskReadFilterByPHYOperation,              //读取过滤PHY
    mk_spp_server_taskReadFilterByRSSIOperation,             //读取过滤RSSI
    mk_spp_server_taskReadFilterByMacAddressOperation,       //读取过滤Mac
    mk_spp_server_taskReadFilterByAdvNameOperation,          //读取过滤ADV Name
    mk_spp_server_taskReadFilterByRawDataStatusOperation,    //读取过滤Raw数据状态
    mk_spp_server_taskReadFilterByBeaconOperation,           //读取过滤iBeacon
    mk_spp_server_taskReadFilterByUIDOperation,              //读取过滤UID
    mk_spp_server_taskReadFilterByURLOperation,              //读取过滤URL
    mk_spp_server_taskReadFilterByTLMOperation,              //读取过滤TLM
    mk_spp_server_taskReadFilterByMKBeaconOperation,         //读取过滤MKiBeacon
    mk_spp_server_taskReadFilterByMKBeaconACCOperation,      //读取过滤MKiBeacon&ACC
    mk_spp_server_taskReadFilterByOtherDatasOperation,       //当前过滤其他的数据
    
#pragma mark - 配置
    mk_spp_server_taskConfigDeviceResetOperation,            //设备恢复出厂设置
    mk_spp_server_taskConfigIndicatorLightStatusOperation,   //配置LED指示灯状态
    mk_spp_server_taskConfigNetworkStatusReportingIntervalOperation,     //配置设备联网状态上报间隔
    mk_spp_server_taskConfigScanSwitchParamsOperation,       //配置扫描开关信息
    mk_spp_server_taskConfigDataReportingTimeoutOperation,   //配置扫描数据超时上报时间
    mk_spp_server_taskConfigDuplicateDataFilterOperation,    //配置扫描重复数据参数
    mk_spp_server_taskConfigConnectionTimeoutOperation,      //配置网络连接超时时长
    mk_spp_server_taskConfigRebootDeviceOperation,           //设备重启
    mk_spp_server_taskConfigNTPServerOperation,              //配置NTP服务器
    mk_spp_server_taskConfigDeviceUTCOperation,              //配置UTC时间
    mk_spp_server_taskConfigUploadDataOptionOperation,       //配置扫描数据上报内容选项
    mk_spp_server_taskConfigFilterRelationshipOperation,     //配置过滤逻辑
    mk_spp_server_taskConfigFilterByPHYOperation,            //配置过滤PHY
    mk_spp_server_taskConfigFilterByRSSIOperation,           //配置过滤RSSI
    mk_spp_server_taskConfigFilterByMacAddressOperation,     //配置过滤mac
    mk_spp_server_taskConfigFilterByADVNameOperation,        //配置过滤ADV Name
    mk_spp_server_taskConfigFilterByBeaconOperation,         //配置过滤iBeacon
    mk_spp_server_taskConfigFilterByUIDOperation,            //配置过滤UID
    mk_spp_server_taskConfigFilterByURLOperation,            //配置过滤URL
    mk_spp_server_taskConfigFilterByTLMOperation,            //配置过滤TLM
    mk_spp_server_taskConfigFilterByMKBeaconOperation,       //配置过滤MKiBeacon
    mk_spp_server_taskConfigFilterByMKBeaconACCOperation,    //配置过滤MKiBeacon&ACC
    mk_spp_server_taskConfigFilterBXPACCOperation,           //配置BeaconX Pro-ACC过滤状态
    mk_spp_server_taskConfigFilterBXPTHOperation,            //配置BeaconX Pro-T&H过滤状态
    mk_spp_server_taskConfigFilterByOtherDatasOperation,     //配置过滤Other数据
    mk_spp_server_taskConfigReconnectNetworkOperation,       //配置设备重入网
    mk_spp_server_taskConfigMQTTServerOperation,             //配置MQTT服务器信息
    mk_spp_server_taskConfigUpdateSlaveFirmwareOperation,    //OTA升级从机固件
    mk_spp_server_taskConfigOTAMasterFirmwareOperation,      //OTA升级主机固件
    mk_spp_server_taskConfigCACertificateOperation,          //OTA CA证书
    mk_spp_server_taskConfigSelfSignedCertificatesOperation, //OTA双向认证证书
};

