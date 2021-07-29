//
//  MKSPServerForAppModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPServerForAppModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

@implementation MKSPServerForAppModel

- (instancetype)init {
    if (self = [super init]) {
        [self loadServerParams];
    }
    return self;
}

- (void)clearAllParams {
    _host = @"";
    _port = @"";
    _clientID = @"";
    _subscribeTopic = @"";
    _publishTopic = @"";
    _cleanSession = NO;
    _qos = 0;
    _keepAlive = @"";
    _userName = @"";
    _password = @"";
    _sslIsOn = NO;
    _certificate = 0;
    _caFileName = @"";
    _clientFileName = @"";
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
    if (self.publishTopic.length > 128 || (ValidStr(self.publishTopic) && ![self.publishTopic isAsciiString])) {
        return @"PublishTopic error";
    }
    if (self.subscribeTopic.length > 128 || (ValidStr(self.subscribeTopic) && ![self.subscribeTopic isAsciiString])) {
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
            if (self.certificate == 2 && !ValidStr(self.clientFileName)) {
                return @"Client File cannot be empty.";
            }
        }
    }
    return @"";
}

#pragma mark - private method
- (void)loadServerParams {
    if (!ValidDict([MKSPServerManager shared].serverParams)) {
        self.cleanSession = YES;
        self.keepAlive = @"60";
        self.qos = 1;
        return;
    }
    self.host = [MKSPServerManager shared].serverParams[@"host"];
    self.port = [MKSPServerManager shared].serverParams[@"port"];
    self.clientID = [MKSPServerManager shared].serverParams[@"clientID"];
    self.subscribeTopic = [MKSPServerManager shared].serverParams[@"subscribeTopic"];
    self.publishTopic = [MKSPServerManager shared].serverParams[@"publishTopic"];
    self.cleanSession = [[MKSPServerManager shared].serverParams[@"cleanSession"] boolValue];
    
    self.qos = [[MKSPServerManager shared].serverParams[@"qos"] integerValue];
    self.keepAlive = [MKSPServerManager shared].serverParams[@"keepAlive"];
    self.userName = [MKSPServerManager shared].serverParams[@"userName"];
    self.password = [MKSPServerManager shared].serverParams[@"password"];
    self.sslIsOn = [[MKSPServerManager shared].serverParams[@"sslIsOn"] boolValue];
    self.certificate = [[MKSPServerManager shared].serverParams[@"certificate"] integerValue];
    self.caFileName = [MKSPServerManager shared].serverParams[@"caFileName"];
    self.clientFileName = [MKSPServerManager shared].serverParams[@"clientFileName"];
}

@end
