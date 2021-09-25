

#pragma mark ****************************************配置参数************************************************


typedef NS_ENUM(NSInteger, mk_sp_otaType) {
    mk_sp_otaType_firmware,
    mk_sp_otaType_CACertificate,
    mk_sp_otaType_privateKey,
    mk_sp_otaType_clientCertificate
};

typedef NS_ENUM(NSInteger, mk_sp_scanFilterConditionShip) {
    mk_sp_scanFilterConditionShipOR,
    mk_sp_scanFilterConditionShipAND
};

typedef NS_ENUM(NSInteger, mk_sp_duplicateDataFilter) {
    mk_sp_duplicateDataFilter_none,
    mk_sp_duplicateDataFilter_mac,
    mk_sp_duplicateDataFilter_macAndDataType,
    mk_sp_duplicateDataFilter_macAndRawData
};

#pragma mark - 蓝牙指示灯状态protocol

@protocol sp_indicatorLightStatusProtocol <NSObject>

@property (nonatomic, assign)BOOL ble_advertising;

@property (nonatomic, assign)BOOL ble_connected;

@property (nonatomic, assign)BOOL wifi_connecting;

@property (nonatomic, assign)BOOL wifi_connected;

@end

#pragma mark - 扫描过滤条件protocol
@protocol sp_beaconTypeFilterProtocol <NSObject>

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

@protocol sp_uploadDataOptionProtocol <NSObject>

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL deviceType;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL rawData;

@end


#pragma mark - 扫描过滤条件部分

typedef NS_ENUM(NSInteger, mk_sp_filterConditionsType) {
    mk_sp_filterConditionsTypeA,
    mk_sp_filterConditionsTypeB
};

typedef NS_ENUM(NSInteger, mk_sp_filterRules) {
    mk_sp_filterRules_off,
    mk_sp_filterRules_forward,          //Filter data forward
    mk_sp_filterRules_reverse,          //Filter data in reverse
};

/*
 这一部分比较复杂
 */

//过滤条件是否打开
static NSString *const MKSPFilterConditionsStatusKey = @"MKSPFilterConditionsStatusKey";

//根据设备广播名字过滤
static NSString * const MKSPFilterByAdvNameKey = @"MKSPFilterByAdvNameKey";

//根据设备mac地址过滤
static NSString *const MKSPFilterByDeviceMacKey = @"MKSPFilterByDeviceMacKey";

//根据设备的iBeacon广播UUID过滤
static NSString *const MKSPFilterByiBeaconUUIDKey = @"MKSPFilterByiBeaconUUIDKey";

//根据设备的iBeacon广播主值过滤
static NSString *const MKSPFilterByiBeaconMajorKey = @"MKSPFilterByiBeaconMajorKey";

//根据设备的iBeacon广播次值过滤
static NSString *const MKSPFilterByiBeaconMinorKey = @"MKSPFilterByiBeaconMinorKey";

//根据设备广播的原始数据过滤
static NSString *const MKSPFilterByRawDataKey = @"MKSPFilterByRawDataKey";

//根据设备的rssi过滤
static NSString *const MKSPFilterByRssiKey = @"MKSPFilterByRssiKey";

//各项过滤条件的过滤规则(关闭、正向、反向)
static NSString *const MKSPFilterRulesKey = @"MKSPFilterRulesKey";


@protocol mk_sp_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end
