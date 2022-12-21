//
//  MKSPAServerForDeviceModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPAServerForDeviceModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKSPInterface+MKSPConfig.h"

#import "MKSPAMQTTManager.h"

static NSString *const defaultSubTopic = @"{device_name}/{device_id}/app_to_device";
static NSString *const defaultPubTopic = @"{device_name}/{device_id}/device_to_app";

@interface MKSPAServerForDeviceModel ()

@property (nonatomic, strong)dispatch_queue_t configQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSPAServerForDeviceModel

- (instancetype)init {
    if (self = [super init]) {
        _host = [MKSPAMQTTManager shared].currentServerParams.host;
        _port = [MKSPAMQTTManager shared].currentServerParams.port;
        _subscribeTopic = defaultSubTopic;
        _publishTopic = defaultPubTopic;
        _cleanSession = YES;
        _keepAlive = @"60";
        _qos = 1;
        _timeZone = 12;
    }
    return self;
}

- (NSString *)checkParams {
    if (!ValidStr(self.host) || self.host.length > 64 || ![self.host isAsciiString]) {
        return @"Host error";
    }
    if (!ValidStr(self.port) || [self.port integerValue] < 0 || [self.port integerValue] > 65535) {
        return @"Port error";
    }
    if (!ValidStr(self.clientID) || self.clientID.length > 64 || ![self.clientID isAsciiString]) {
        return @"ClientID error";
    }
    if (!ValidStr(self.publishTopic) || self.publishTopic.length > 128 || ![self.publishTopic isAsciiString]) {
        return @"PublishTopic error";
    }
    if (!ValidStr(self.subscribeTopic) || self.subscribeTopic.length > 128 || ![self.subscribeTopic isAsciiString]) {
        return @"SubscribeTopic error";
    }
    if (self.qos < 0 || self.qos > 2) {
        return @"Qos error";
    }
    if (!ValidStr(self.keepAlive) || [self.keepAlive integerValue] < 10 || [self.keepAlive integerValue] > 120) {
        return @"KeepAlive error";
    }
    if (self.userName.length > 256 || (ValidStr(self.userName) && ![self.userName isAsciiString])) {
        return @"UserName error";
    }
    if (self.password.length > 256 || (ValidStr(self.password) && ![self.password isAsciiString])) {
        return @"Password error";
    }
    if (self.sslIsOn) {
        if (self.certificate < 0 || self.certificate > 2) {
            return @"Certificate error";
        }
        if (self.certificate > 0) {
            if (!ValidStr(self.caFileName)) {
                return @"CA File cannot be empty.";
            }
            if (self.certificate == 2 && (!ValidStr(self.clientKeyName) || !ValidStr(self.clientCertName))) {
                return @"Client File cannot be empty.";
            }
        }
    }
    if (!ValidStr(self.deviceID) || self.deviceID.length > 32 || ![self.deviceID isAsciiString]) {
        return @"DeviceID error";
    }
    if (self.ntpHost.length > 64 || (ValidStr(self.ntpHost) && ![self.ntpHost isAsciiString])) {
        return @"NTP URL error";
    }
    if (self.timeZone < 0 || self.timeZone > 24) {
        return @"TimeZone error";
    }
    return @"";
}

- (void)readPramsFromDeviceWithSucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.configQueue, ^{
        if (![self readDeviceMac]) {
            [self operationFailedBlockWithMsg:@"Read Mac Address Error" block:failedBlock];
            return;
        }
        if (![self readDeviceName]) {
            [self operationFailedBlockWithMsg:@"Read Device Name Error" block:failedBlock];
            return;
        }
        if (self.supportRead) {
            if (![self readConnectMode]) {
                [self operationFailedBlockWithMsg:@"Read Connect Mode Error" block:failedBlock];
                return;
            }
            if (![self readHost]) {
                [self operationFailedBlockWithMsg:@"Read Host Error" block:failedBlock];
                return;
            }
            if (![self readPort]) {
                [self operationFailedBlockWithMsg:@"Read Port Error" block:failedBlock];
                return;
            }
            if (![self readCleanSession]) {
                [self operationFailedBlockWithMsg:@"Read Clean Session Error" block:failedBlock];
                return;
            }
            if (![self readKeepAlive]) {
                [self operationFailedBlockWithMsg:@"Read Keep Alive Error" block:failedBlock];
                return;
            }
            if (![self readQos]) {
                [self operationFailedBlockWithMsg:@"Read Qos Error" block:failedBlock];
                return;
            }
            if (![self readClientID]) {
                [self operationFailedBlockWithMsg:@"Read Client ID Error" block:failedBlock];
                return;
            }
            if (![self readDeviceID]) {
                [self operationFailedBlockWithMsg:@"Read Device ID Error" block:failedBlock];
                return;
            }
            if (![self readSubTopic]) {
                [self operationFailedBlockWithMsg:@"Read Sub Topic Error" block:failedBlock];
                return;
            }
            if (![self readPubTopic]) {
                [self operationFailedBlockWithMsg:@"Read Pub Topic Error" block:failedBlock];
                return;
            }
            if (![self readServerUsername]) {
                [self operationFailedBlockWithMsg:@"Read Server Username Error" block:failedBlock];
                return;
            }
            if (![self readServerPassword]) {
                [self operationFailedBlockWithMsg:@"Read Server Password Error" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configParamsWithWifiSSID:(NSString *)ssid
                        password:(NSString *)password
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.configQueue, ^{
        if (!ValidStr(ssid) || ssid.length > 64) {
            [self operationFailedBlockWithMsg:@"Wifi SSID Error" block:failedBlock];
            return;
        }
        if (password.length > 64) {
            [self operationFailedBlockWithMsg:@"Wifi Password Error" block:failedBlock];
            return;
        }
        NSString *checkMsg = [self checkParams];
        if (ValidStr(checkMsg)) {
            [self operationFailedBlockWithMsg:checkMsg block:failedBlock];
            return;
        }
        if (![self configHost]) {
            [self operationFailedBlockWithMsg:@"Config Host Error" block:failedBlock];
            return;
        }
        if (![self configPort]) {
            [self operationFailedBlockWithMsg:@"Config Port Error" block:failedBlock];
            return;
        }
        if (![self configClientID]) {
            [self operationFailedBlockWithMsg:@"Config Client Id Error" block:failedBlock];
            return;
        }
        if (![self configSubscribe]) {
            [self operationFailedBlockWithMsg:@"Config Subscribe Topic Error" block:failedBlock];
            return;
        }
        if (![self configPublish]) {
            [self operationFailedBlockWithMsg:@"Config Publish Topic Error" block:failedBlock];
            return;
        }
        if (![self configCleanSession]) {
            [self operationFailedBlockWithMsg:@"Config Clean Session Error" block:failedBlock];
            return;
        }
        if (![self configQos]) {
            [self operationFailedBlockWithMsg:@"Config Qos Error" block:failedBlock];
            return;
        }
        if (![self configKeepAlive]) {
            [self operationFailedBlockWithMsg:@"Config Keep Alive Error" block:failedBlock];
            return;
        }
        if (![self configUserName]) {
            [self operationFailedBlockWithMsg:@"Config UserName Error" block:failedBlock];
            return;
        }
        if (![self configPassword]) {
            [self operationFailedBlockWithMsg:@"Config Password Error" block:failedBlock];
            return;
        }
        if (![self configSSLStatus]) {
            [self operationFailedBlockWithMsg:@"Config SSL Status Error" block:failedBlock];
            return;
        }
        if (self.sslIsOn && self.certificate > 0) {
            if (![self configCAFile]) {
                [self operationFailedBlockWithMsg:@"Config CA File Error" block:failedBlock];
                return;
            }
            if (self.certificate == 2) {
                //双向验证
                if (![self configClientKey]) {
                    [self operationFailedBlockWithMsg:@"Config Client Key Error" block:failedBlock];
                    return;
                }
                if (![self configClientCert]) {
                    [self operationFailedBlockWithMsg:@"Config Client Cert Error" block:failedBlock];
                    return;
                }
            }
        }
        if (![self configDeviceID]) {
            [self operationFailedBlockWithMsg:@"Config Device ID Error" block:failedBlock];
            return;
        }
        if (![self configNTPHost]) {
            [self operationFailedBlockWithMsg:@"Config NTP URL Error" block:failedBlock];
            return;
        }
        if (![self configTimeZone]) {
            [self operationFailedBlockWithMsg:@"Config Time Zone Error" block:failedBlock];
            return;
        }
        if (![self configWifiSSID:ssid]) {
            [self operationFailedBlockWithMsg:@"Config Wifi SSID Error" block:failedBlock];
            return;
        }
        if (![self configWifiPassword:password]) {
            [self operationFailedBlockWithMsg:@"Config Wifi Password Error" block:failedBlock];
            return;
        }
        if (![self exitConfigMode]) {
            [self operationFailedBlockWithMsg:@"Exit Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface

#pragma mark - 参数配置

- (BOOL)configHost {
    __block BOOL success = NO;
    [MKSPInterface sp_configServerHost:self.host sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPort {
    __block BOOL success = NO;
    [MKSPInterface sp_configServerPort:[self.port integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configClientID {
    __block BOOL success = NO;
    [MKSPInterface sp_configClientID:self.clientID sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSubscribe {
    __block BOOL success = NO;
    NSString *topic = @"";
    if ([self.subscribeTopic isEqualToString:defaultSubTopic]) {
        //用户使用默认的topic
        topic = [NSString stringWithFormat:@"%@/%@/%@",self.deviceName,self.deviceID,@"app_to_device"];
    }else {
        //用户修改了topic
        topic = self.subscribeTopic;
    }
    [MKSPInterface sp_configSubscibeTopic:topic sucBlock:^{
        success = YES;
        self.subscribeTopic = topic;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPublish {
    __block BOOL success = NO;
    NSString *topic = @"";
    if ([self.publishTopic isEqualToString:defaultPubTopic]) {
        //用户使用默认的topic
        topic = [NSString stringWithFormat:@"%@/%@/%@",self.deviceName,self.deviceID,@"device_to_app"];
    }else {
        //用户修改了topic
        topic = self.publishTopic;
    }
    [MKSPInterface sp_configPublishTopic:topic sucBlock:^{
        success = YES;
        self.publishTopic = topic;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCleanSession {
    __block BOOL success = NO;
    [MKSPInterface sp_configServerCleanSession:self.cleanSession sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configQos {
    __block BOOL success = NO;
    [MKSPInterface sp_configServerQos:self.qos sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configKeepAlive {
    __block BOOL success = NO;
    [MKSPInterface sp_configServerKeepAlive:[self.keepAlive integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configUserName {
    __block BOOL success = NO;
    [MKSPInterface sp_configServerUserName:self.userName sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPassword {
    __block BOOL success = NO;
    [MKSPInterface sp_configServerPassword:self.password sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSSLStatus {
    __block BOOL success = NO;
    mk_sp_connectMode mode = mk_sp_connectMode_TCP;
    if (self.sslIsOn) {
        if (self.certificate == 0) {
            mode = mk_sp_connectMode_CASignedServerCertificate;
        }else if (self.certificate == 1) {
            mode = mk_sp_connectMode_CACertificate;
        }else if (self.certificate == 2) {
            mode = mk_sp_connectMode_SelfSignedCertificates;
        }
    }
    [MKSPInterface sp_configConnectMode:mode sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCAFile {
    __block BOOL success = NO;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [document stringByAppendingPathComponent:self.caFileName];
    NSData *caData = [NSData dataWithContentsOfFile:filePath];
    if (!ValidData(caData)) {
        return NO;
    }
    [MKSPInterface sp_configCAFile:caData sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configClientKey {
    __block BOOL success = NO;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [document stringByAppendingPathComponent:self.clientKeyName];
    NSData *clientKeyData = [NSData dataWithContentsOfFile:filePath];
    if (!ValidData(clientKeyData)) {
        return NO;
    }
    [MKSPInterface sp_configClientPrivateKey:clientKeyData sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configClientCert {
    __block BOOL success = NO;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [document stringByAppendingPathComponent:self.clientCertName];
    NSData *clientCertData = [NSData dataWithContentsOfFile:filePath];
    if (!ValidData(clientCertData)) {
        return NO;
    }
    [MKSPInterface sp_configClientCert:clientCertData sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDeviceID {
    __block BOOL success = NO;
    [MKSPInterface sp_configDeviceID:self.deviceID sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNTPHost {
    __block BOOL success = NO;
    [MKSPInterface sp_configNTPServerHost:self.ntpHost sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTimeZone {
    __block BOOL success = NO;
    [MKSPInterface sp_configTimeZone:(self.timeZone - 12) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configWifiSSID:(NSString *)ssid {
    __block BOOL success = NO;
    [MKSPInterface sp_configWIFISSID:ssid sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configWifiPassword:(NSString *)password {
    __block BOOL success = NO;
    [MKSPInterface sp_configWIFIPassword:password sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)exitConfigMode {
    __block BOOL success = NO;
    [MKSPInterface sp_exitConfigModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - 参数读取
- (BOOL)readDeviceMac {
    __block BOOL success = NO;
    [MKSPInterface sp_readDeviceMacAddressWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = returnData[@"result"][@"macAddress"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDeviceName {
    __block BOOL success = NO;
    [MKSPInterface sp_readDeviceNameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.deviceName = returnData[@"result"][@"deviceName"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readConnectMode {
    __block BOOL success = NO;
    [MKSPInterface sp_readConnectModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger mode = [returnData[@"result"][@"mode"] integerValue];
        if (mode == 0) {
            self.sslIsOn = NO;
        }else {
            self.sslIsOn = YES;
            self.certificate = (mode - 1);
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHost {
    __block BOOL success = NO;
    [MKSPInterface sp_readServerHostWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.host = returnData[@"result"][@"host"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPort {
    __block BOOL success = NO;
    [MKSPInterface sp_readServerPortWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.port = returnData[@"result"][@"port"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCleanSession {
    __block BOOL success = NO;
    [MKSPInterface sp_readServerCleanSessionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.cleanSession = [returnData[@"result"][@"clean"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readKeepAlive {
    __block BOOL success = NO;
    [MKSPInterface sp_readServerKeepAliveWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.keepAlive = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readQos {
    __block BOOL success = NO;
    [MKSPInterface sp_readServerQosWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.qos = [returnData[@"result"][@"qos"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readClientID {
    __block BOOL success = NO;
    [MKSPInterface sp_readClientIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.clientID = returnData[@"result"][@"clientID"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDeviceID {
    __block BOOL success = NO;
    [MKSPInterface sp_readDeviceIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.deviceID = returnData[@"result"][@"deviceID"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSubTopic {
    __block BOOL success = NO;
    [MKSPInterface sp_readSubscibeTopicWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.subscribeTopic = returnData[@"result"][@"topic"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPubTopic {
    __block BOOL success = NO;
    [MKSPInterface sp_readPublishTopicWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.publishTopic = returnData[@"result"][@"topic"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNTPServerHost {
    __block BOOL success = NO;
    [MKSPInterface sp_readNTPServerHostWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.ntpHost = returnData[@"result"][@"host"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTimezone {
    __block BOOL success = NO;
    [MKSPInterface sp_readTimeZoneWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeZone = [returnData[@"result"][@"timeZone"] integerValue] + 12;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readServerUsername {
    __block BOOL success = NO;
    [MKSPInterface sp_readServerUserNameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.userName = returnData[@"result"][@"userName"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readServerPassword {
    __block BOOL success = NO;
    [MKSPInterface sp_readServerPasswordWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.password = returnData[@"result"][@"password"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"serverParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)configQueue {
    if (!_configQueue) {
        _configQueue = dispatch_queue_create("serverSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _configQueue;
}

@end
