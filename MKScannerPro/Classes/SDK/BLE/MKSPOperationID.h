

typedef NS_ENUM(NSInteger, mk_sp_taskOperationID) {
    mk_sp_defaultTaskOperationID,
    
#pragma mark - Read
    mk_sp_taskReadFirmwareOperation,           //读取固件版本
    mk_sp_taskReadHardwareOperation,           //读取硬件类型
    mk_sp_taskReadDeviceNameOperation,         //读取设备名称
    
#pragma mark - 自定义协议读取
    mk_sp_taskReadWIFISSIDOperation,            //读取设备当前的wifi ssid
    mk_sp_taskReadWIFIPasswordOperation,        //读取设备当前的wifi密码
    mk_sp_taskReadConnectModeOperation,         //读取MTQQ服务器通信加密方式
    mk_sp_taskReadServerHostOperation,          //读取MQTT服务器域名
    mk_sp_taskReadServerPortOperation,          //读取MQTT服务器端口
    mk_sp_taskReadServerCleanSessionOperation,  //读取MQTT Clean Session
    mk_sp_taskReadServerKeepAliveOperation,     //读取MQTT KeepAlive
    mk_sp_taskReadServerQosOperation,           //读取MQTT Qos
    mk_sp_taskReadClientIDOperation,            //读取Client ID
    mk_sp_taskReadDeviceIDOperation,            //读取Device ID
    mk_sp_taskReadSubscibeTopicOperation,       //读取Subscribe topic
    mk_sp_taskReadPublishTopicOperation,        //读取Publish topic
    mk_sp_taskReadNTPServerHostOperation,       //读取NTP服务器域名
    mk_sp_taskReadTimeZoneOperation,            //读取时区
    mk_sp_taskReadDeviceMacAddressOperation,    //读取Mca地址
    mk_sp_taskReadDeviceTypeOperation,          //读取设备类型
        
#pragma mark - 密码特征
    mk_sp_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 配置
    mk_sp_taskExitConfigModeOperation,          //设备退出配置模式
    mk_sp_taskConfigWIFISSIDOperation,          //配置wifi的ssid
    mk_sp_taskConfigWIFIPasswordOperation,      //配置wifi的密码
    mk_sp_taskConfigConnectModeOperation,       //配置MTQQ服务器通信加密方式
    mk_sp_taskConfigServerHostOperation,        //配置MQTT服务器域名
    mk_sp_taskConfigServerPortOperation,        //配置MQTT服务器端口
    mk_sp_taskConfigServerCleanSessionOperation,    //配置MQTT Clean Session
    mk_sp_taskConfigServerKeepAliveOperation,       //配置MQTT KeepAlive
    mk_sp_taskConfigServerQosOperation,             //配置MQTT Qos
    mk_sp_taskConfigClientIDOperation,              //配置ClientID
    mk_sp_taskConfigDeviceIDOperation,              //配置DeviceID
    mk_sp_taskConfigSubscibeTopicOperation,         //配置Subscribe topic
    mk_sp_taskConfigPublishTopicOperation,          //配置Publish topic
    mk_sp_taskConfigNTPServerHostOperation,         //配置NTP服务器域名
    mk_sp_taskConfigTimeZoneOperation,              //配置时区
    
    mk_sp_taskConfigServerUserNameOperation,        //配置服务器的登录用户名
    mk_sp_taskConfigServerPasswordOperation,        //配置服务器的登录密码
    mk_sp_taskConfigCAFileOperation,                //配置CA证书
    mk_sp_taskConfigClientCertOperation,            //配置设备证书
    mk_sp_taskConfigClientPrivateKeyOperation,      //配置私钥
};

