

#pragma mark ****************************************配置参数************************************************


typedef NS_ENUM(NSInteger, mk_spa_otaType) {
    mk_spa_otaType_firmware,
    mk_spa_otaType_CACertificate,
    mk_spa_otaType_privateKey,
    mk_spa_otaType_clientCertificate
};

typedef NS_ENUM(NSInteger, mk_spa_scanFilterConditionShip) {
    mk_spa_scanFilterConditionShipOR,
    mk_spa_scanFilterConditionShipAND
};

typedef NS_ENUM(NSInteger, mk_spa_duplicateDataFilter) {
    mk_spa_duplicateDataFilter_none,
    mk_spa_duplicateDataFilter_mac,
    mk_spa_duplicateDataFilter_macAndDataType,
    mk_spa_duplicateDataFilter_macAndRawData
};

#pragma mark - 蓝牙指示灯状态protocol

@protocol spa_indicatorLightStatusProtocol <NSObject>

@property (nonatomic, assign)BOOL ble_advertising;

@property (nonatomic, assign)BOOL ble_connected;

@property (nonatomic, assign)BOOL wifi_connecting;

@property (nonatomic, assign)BOOL wifi_connected;

@end

#pragma mark - 扫描过滤条件protocol
@protocol spa_beaconTypeFilterProtocol <NSObject>

@property (nonatomic, assign)BOOL iBeacon;

@property (nonatomic, assign)BOOL uid;

@property (nonatomic, assign)BOOL url;

@property (nonatomic, assign)BOOL tlm;

@property (nonatomic, assign)BOOL MKiBeacon;

@property (nonatomic, assign)BOOL MKiBeaconACC;

@property (nonatomic, assign)BOOL bxpAcc;

@property (nonatomic, assign)BOOL bxpTH;

@property (nonatomic, assign)BOOL unknown;

@end


#pragma mark - 扫描数据上报内容选项protocol

@protocol spa_uploadDataOptionProtocol <NSObject>

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL deviceType;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL rawData;

@end


#pragma mark - 扫描过滤条件部分

typedef NS_ENUM(NSInteger, mk_spa_filterConditionsType) {
    mk_spa_filterConditionsTypeA,
    mk_spa_filterConditionsTypeB
};

typedef NS_ENUM(NSInteger, mk_spa_filterRules) {
    mk_spa_filterRules_off,
    mk_spa_filterRules_forward,          //Filter data forward
    mk_spa_filterRules_reverse,          //Filter data in reverse
};

/*
 这一部分比较复杂
 */

//过滤条件是否打开
static NSString *const MKSPAFilterConditionsStatusKey = @"MKSPAFilterConditionsStatusKey";

//根据设备广播名字过滤
static NSString * const MKSPAFilterByAdvNameKey = @"MKSPAFilterByAdvNameKey";

//根据设备mac地址过滤
static NSString *const MKSPAFilterByDeviceMacKey = @"MKSPAFilterByDeviceMacKey";

//根据设备的iBeacon广播UUID过滤
static NSString *const MKSPAFilterByiBeaconUUIDKey = @"MKSPAFilterByiBeaconUUIDKey";

//根据设备的iBeacon广播主值过滤
static NSString *const MKSPAFilterByiBeaconMajorKey = @"MKSPAFilterByiBeaconMajorKey";

//根据设备的iBeacon广播次值过滤
static NSString *const MKSPAFilterByiBeaconMinorKey = @"MKSPAFilterByiBeaconMinorKey";

//根据设备广播的原始数据过滤
static NSString *const MKSPAFilterByRawDataKey = @"MKSPAFilterByRawDataKey";

//根据设备的rssi过滤
static NSString *const MKSPAFilterByRssiKey = @"MKSPAFilterByRssiKey";

//各项过滤条件的过滤规则(关闭、正向、反向)
static NSString *const MKSPAFilterRulesKey = @"MKSPAFilterRulesKey";


@protocol mk_spa_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end
