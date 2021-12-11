

typedef NS_ENUM(NSInteger, mk_spa_serverOperationID) {
    mk_spa_defaultServerOperationID,
    
#pragma mark - 读取
    mk_spa_server_taskReadDeviceInfoOperation,               //读取设备信息
    mk_spa_server_taskReadDeviceUTCOperation,                //读取UTC时间
    mk_spa_server_taskReadIndicatorLightStatusOperation,     //读取LED指示灯状态
    mk_spa_server_taskReadNetworkStatusReportingIntervalOperation,   //读取设备联网状态上报间隔
    mk_spa_server_taskReadScanSwitchParamsOperation,         //读取扫描开关信息
    mk_spa_server_taskReadDataReportingTimeoutOperation,     //读取扫描数据超时上报时间
    mk_spa_server_taskReadUploadDataOptionOperation,         //读取扫描数据上报内容选项
    mk_spa_server_taskReadDuplicateDataFilterOperation,      //读取扫描重复数据参数
    mk_spa_server_taskReadBeaconTypeFilterDatasOperation,    //读取类型过滤选择
    mk_spa_server_taskReadScanFilterConditionsOperation,     //读取扫描过滤条件关系
    mk_spa_server_taskReadFilterConditionsAOperation,        //读取扫描过滤条件A
    mk_spa_server_taskReadFilterConditionsBOperation,        //读取扫描过滤条件B
    mk_spa_server_taskReadDeviceMQTTServerInfoOperation,     //读取设备的MQTT服务器信息
    mk_spa_server_taskReadConnectionTimeoutOperation,        //读取网络连接超时时长
    mk_spa_server_taskReadScanTimeoutOptionOperation,        //读取蓝牙扫描超时重启时长
    
#pragma mark - 配置
    mk_spa_server_taskConfigDeviceResetOperation,            //设备恢复出厂设置
    mk_spa_server_taskConfigDeviceOTAOperation,              //配置OTA
    mk_spa_server_taskConfigDeviceUTCOperation,              //配置UTC时间
    mk_spa_server_taskConfigIndicatorLightStatusOperation,   //配置LED指示灯状态
    mk_spa_server_taskConfigNetworkStatusReportingIntervalOperation,     //配置设备联网状态上报间隔
    mk_spa_server_taskConfigScanSwitchParamsOperation,       //配置扫描开关信息
    mk_spa_server_taskConfigDataReportingTimeoutOperation,   //配置扫描数据超时上报时间
    mk_spa_server_taskConfigUploadDataOptionOperation,       //配置扫描数据上报内容选项
    mk_spa_server_taskConfigDuplicateDataFilterOperation,    //配置扫描重复数据参数
    mk_spa_server_taskConfigBeaconTypeFilterOperation,       //配置类型过滤选择
    mk_spa_server_taskConfigScanFilterConditionsOperation,   //配置扫描过滤条件关系
    mk_spa_server_taskConfigFilterConditionsAOperation,      //配置扫描过滤条件A
    mk_spa_server_taskConfigFilterConditionsBOperation,      //配置扫描过滤条件B
    mk_spa_server_taskConfigConnectionTimeoutOperation,      //配置网络连接超时时长
    mk_spa_server_taskConfigScanTimeoutOptionOperation,      //配置蓝牙扫描超时重启时长
    mk_spa_server_taskConfigRebootDeviceOperation,           //设备重启
};

