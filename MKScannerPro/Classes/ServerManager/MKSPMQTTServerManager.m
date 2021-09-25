//
//  MKSPMQTTServerManager.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/9/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPMQTTServerManager.h"

#import "MQTTSSLSecurityPolicyTransport.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKNetworkManager.h"

#import "MKSPServerManager.h"

#import "MKSPServerParamsModel.h"

static MKSPMQTTServerManager *manager = nil;
static dispatch_once_t onceToken;

@interface NSObject (MKSPMQTTServerManager)

@end

@implementation NSObject (MKSPMQTTServerManager)

+ (void)load{
    [MKSPMQTTServerManager shared];
}

@end

@interface MKSPMQTTServerManager ()

@property (nonatomic, strong)MKSPServerParamsModel *paramsModel;

@end

@implementation MKSPMQTTServerManager

- (void)dealloc{
    NSLog(@"销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:MKNetworkStatusChangedNotification
                                         object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:UIApplicationDidBecomeActiveNotification
                                         object:nil];
    }
    return self;
}

+ (MKSPMQTTServerManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKSPMQTTServerManager new];
        }
    });
    return manager;
}

#pragma mark - note
- (void)networkStateChanged{
    if (![self.paramsModel paramsCanConnectServer]) {
        //服务器连接参数缺失
        return;
    }
    if (![[MKNetworkManager sharedInstance] currentNetworkAvailable]) {
        //如果是当前网络不可用，则断开当前手机与mqtt服务器的连接操作
        [[MKSPServerManager shared] disconnect];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSPMQTTSessionManagerStateChangedNotification object:nil];
        return;
    }
    if ([MKSPServerManager shared].state == MKMQTTSessionManagerStateConnected
        || [MKSPServerManager shared].state == MKMQTTSessionManagerStateConnecting) {
        //已经连接或者正在连接，直接返回
        return;
    }
    //如果网络可用，则连接
    [self connect];
}

- (BOOL)saveServerParams:(id <MKSPMQTTServerParamsProtocol>)protocol {
    return [self.paramsModel saveServerParams:protocol];
}

- (id<MKSPMQTTServerParamsProtocol>)currentServerParams {
    return self.paramsModel;
}

- (BOOL)clearLocalData {
    return [self.paramsModel clearLocalData];
}

- (BOOL)connect {
    if (![self.paramsModel paramsCanConnectServer]) {
        return NO;
    }
    MQTTSSLSecurityPolicy *securityPolicy = nil;
    NSArray *certList = nil;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if (self.paramsModel.sslIsOn) {
        //需要ssl验证
        if (self.paramsModel.certificate == 0) {
            //不需要CA根证书
            securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
        }
        if (self.paramsModel.certificate == 1 || self.paramsModel.certificate == 2) {
            //需要CA证书
            NSString *filePath = [document stringByAppendingPathComponent:self.paramsModel.caFileName];
            NSData *clientCert = [NSData dataWithContentsOfFile:filePath];
            if (ValidData(clientCert)) {
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeCertificate];
                securityPolicy.pinnedCertificates = @[clientCert];
            }else {
                //未加载到CA证书
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
            }
        }
        if (self.paramsModel.certificate == 2) {
            //双向验证
            NSString *filePath = [document stringByAppendingPathComponent:self.paramsModel.clientFileName];
            certList = [MQTTSSLSecurityPolicyTransport clientCertsFromP12:filePath passphrase:@"123456"];
        }
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        securityPolicy.validatesCertificateChain = NO;
    }
    [[MKSPServerManager shared] connectTo:self.paramsModel.host
                                     port:[self.paramsModel.port integerValue]
                                      tls:self.paramsModel.sslIsOn
                                keepalive:[self.paramsModel.keepAlive integerValue]
                                    clean:self.paramsModel.cleanSession
                                     auth:YES
                                     user:self.paramsModel.userName
                                     pass:self.paramsModel.password
                                     will:NO
                                willTopic:nil
                                  willMsg:nil
                                  willQos:0
                           willRetainFlag:NO
                             withClientId:self.paramsModel.clientID
                           securityPolicy:securityPolicy
                             certificates:certList
                            protocolLevel:MQTTProtocolVersion311
                           connectHandler:nil];
    return YES;
}

#pragma mark - getter
- (MKSPServerParamsModel *)paramsModel {
    if (!_paramsModel) {
        _paramsModel = [[MKSPServerParamsModel alloc] init];
    }
    return _paramsModel;
}

@end
