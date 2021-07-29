

typedef NS_ENUM(NSInteger, mk_sp_serverOperationID) {
    mk_sp_defaultServerOperationID,
    
#pragma mark - 读取
    mk_sp_server_taskReadDeviceInfoOperation,               //读取设备信息
    mk_sp_server_taskReadDeviceUTCOperation,                //读取UTC时间
    mk_sp_server_taskReadIndicatorLightStatusOperation,     //读取LED指示灯状态
    mk_sp_server_taskReadNetworkStatusReportingIntervalOperation,   //读取设备联网状态上报间隔
    mk_sp_server_taskReadScanSwitchParamsOperation,         //读取扫描开关信息
    mk_sp_server_taskReadDataReportingTimeoutOperation,     //读取扫描数据超时上报时间
    mk_sp_server_taskReadUploadDataOptionOperation,         //读取扫描数据上报内容选项
    mk_sp_server_taskReadDuplicateDataFilterOperation,      //读取扫描重复数据参数
    mk_sp_server_taskReadBeaconTypeFilterDatasOperation,    //读取类型过滤选择
    mk_sp_server_taskReadScanFilterConditionsOperation,     //读取扫描过滤条件关系
    mk_sp_server_taskReadFilterConditionsAOperation,        //读取扫描过滤条件A
    mk_sp_server_taskReadFilterConditionsBOperation,        //读取扫描过滤条件B
    mk_sp_server_taskReadDeviceMQTTServerInfoOperation,     //读取设备的MQTT服务器信息
    mk_sp_server_taskReadConnectionTimeoutOperation,        //读取网络连接超时时长
    
#pragma mark - 配置
    mk_sp_server_taskConfigDeviceResetOperation,            //设备恢复出厂设置
    mk_sp_server_taskConfigDeviceOTAOperation,              //配置OTA
    mk_sp_server_taskConfigDeviceUTCOperation,              //配置UTC时间
    mk_sp_server_taskConfigIndicatorLightStatusOperation,   //配置LED指示灯状态
    mk_sp_server_taskConfigNetworkStatusReportingIntervalOperation,     //配置设备联网状态上报间隔
    mk_sp_server_taskConfigScanSwitchParamsOperation,       //配置扫描开关信息
    mk_sp_server_taskConfigDataReportingTimeoutOperation,   //配置扫描数据超时上报时间
    mk_sp_server_taskConfigUploadDataOptionOperation,       //配置扫描数据上报内容选项
    mk_sp_server_taskConfigDuplicateDataFilterOperation,    //配置扫描重复数据参数
    mk_sp_server_taskConfigBeaconTypeFilterOperation,       //配置类型过滤选择
    mk_sp_server_taskConfigScanFilterConditionsOperation,   //配置扫描过滤条件关系
    mk_sp_server_taskConfigFilterConditionsAOperation,      //配置扫描过滤条件A
    mk_sp_server_taskConfigFilterConditionsBOperation,      //配置扫描过滤条件B
    mk_sp_server_taskConfigConnectionTimeoutOperation,      //配置网络连接超时时长
};

