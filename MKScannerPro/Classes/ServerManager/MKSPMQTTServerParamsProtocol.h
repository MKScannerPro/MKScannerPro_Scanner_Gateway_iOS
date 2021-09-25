//
//  MKSPMQTTServerParamsProtocol.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/9/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKSPMQTTServerParamsProtocol <NSObject>

/// 1-64 Characters
@property (nonatomic, copy)NSString *host;

/// 0~65535
@property (nonatomic, copy)NSString *port;

/// 1-64 Characters
@property (nonatomic, copy)NSString *clientID;

/// 0-128 Characters
@property (nonatomic, copy)NSString *subscribeTopic;

/// 0-128 Characters
@property (nonatomic, copy)NSString *publishTopic;

@property (nonatomic, assign)BOOL cleanSession;

/// 0、1、2
@property (nonatomic, assign)NSInteger qos;

/// 10-120
@property (nonatomic, copy)NSString *keepAlive;

/// 0-256 Characters
@property (nonatomic, copy)NSString *userName;

/// 0-256 Characters
@property (nonatomic, copy)NSString *password;

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

/// 根证书
@property (nonatomic, copy)NSString *caFileName;

/// 对于app是.p12证书
@property (nonatomic, copy)NSString *clientFileName;

@end

NS_ASSUME_NONNULL_END
