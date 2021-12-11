

#pragma mark ****************************************配置参数************************************************

typedef NS_ENUM(NSInteger, mk_spp_duplicateDataFilter) {
    mk_spp_duplicateDataFilter_none,
    mk_spp_duplicateDataFilter_mac,
    mk_spp_duplicateDataFilter_macAndDataType,
    mk_spp_duplicateDataFilter_macAndRawData
};

#pragma mark - 蓝牙指示灯状态protocol

@protocol spp_indicatorLightStatusProtocol <NSObject>

@property (nonatomic, assign)BOOL ble_advertising;

@property (nonatomic, assign)BOOL ble_connected;

@property (nonatomic, assign)BOOL wifi_connecting;

@property (nonatomic, assign)BOOL wifi_connected;

@end

#pragma mark - 扫描数据上报内容选项protocol

@protocol spp_uploadDataOptionProtocol <NSObject>

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL deviceType;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL rawData_advertising;

@property (nonatomic, assign)BOOL rawData_response;

@end


@protocol spp_updateMQTTServerProtocol <NSObject>

/// mqtt host  1-64 Characters
@property (nonatomic, copy)NSString *mqtt_host;

/// mqtt port   0-65535
@property (nonatomic, assign)NSInteger mqtt_port;

/// 1-64 Characters
@property (nonatomic, copy)NSString *clientID;

/// 1-128 Characters
@property (nonatomic, copy)NSString *subscribeTopic;

/// 1-128 Characters
@property (nonatomic, copy)NSString *publishTopic;

@property (nonatomic, assign)BOOL cleanSession;

/// 0:Qos0 1:Qos1 2:Qos2
@property (nonatomic, assign)NSInteger qos;

/// 10s~120s
@property (nonatomic, assign)NSInteger keepAlive;

/// 0-256 Characters
@property (nonatomic, copy)NSString *mqtt_userName;

/// 0-256 Characters
@property (nonatomic, copy)NSString *mqtt_password;

/// 0:TCP    1:CA signed server certificate     2:CA certificate     3:Self signed certificates
@property (nonatomic, assign)NSInteger connect_mode;

/// Host of the server where the certificate is located.1-64 Characters
@property (nonatomic, copy)NSString *sslHost;

/// Port of the server where the certificate is located.0~65535
@property (nonatomic, assign)NSInteger sslPort;

/// The path of the CA certificate on the ssl certificate server.1-100Characters
@property (nonatomic, copy)NSString *caFilePath;

/// The path of the Client Private Key on the ssl certificate server.1-100Characters
@property (nonatomic, copy)NSString *clientKeyPath;

/// The path of the Client certificate on the ssl certificate server.1-100Characters
@property (nonatomic, copy)NSString *clientCertPath;

/// Ssid of networked wifi.1-32Characters.
@property (nonatomic, copy)NSString *wifiSSID;

/// Password of networked wifi.0-64Characters.
@property (nonatomic, copy)NSString *wifiPassword;

@end


#pragma mark - 扫描过滤条件部分

typedef NS_ENUM(NSInteger, mk_spp_filterRelationship) {
    mk_spp_filterRelationship_null,
    mk_spp_filterRelationship_mac,
    mk_spp_filterRelationship_advName,
    mk_spp_filterRelationship_rawData,
    mk_spp_filterRelationship_advNameAndRawData,
    mk_spp_filterRelationship_advNameAndRawDataAndMac,
    mk_spp_filterRelationship_advNameOrRawData,
};

typedef NS_ENUM(NSInteger, mk_spp_PHYMode) {
    mk_spp_PHYMode_BLE4,                     //1M PHY (BLE 4.x)
    mk_spp_PHYMode_BLE5,                     //1M PHY (BLE 5)
    mk_spp_PHYMode_BLE4AndBLE5,              //1M PHY (BLE 4.x + BLE 5)
    mk_spp_PHYMode_CodedBLE5,                //Coded PHY(BLE 5)
};

typedef NS_ENUM(NSInteger, mk_spp_filterByTLM) {
    mk_spp_filterByTLM_null,                //Filter all Eddystone_TLM data
    mk_spp_filterByTLM_nonEncrypted,        //Non-encrypted type TLM
    mk_spp_filterByTLM_encrypted,           //Encryption type TLM
};

typedef NS_ENUM(NSInteger, mk_spp_filterByOther) {
    mk_spp_filterByOther_A,                 //Filter by A condition.
    mk_spp_filterByOther_AB,                //Filter by A & B condition.
    mk_spp_filterByOther_AOrB,              //Filter by A | B condition.
    mk_spp_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_spp_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_spp_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};


@protocol mk_spp_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end
