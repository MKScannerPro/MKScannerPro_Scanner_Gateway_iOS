//
//  CBPeripheral+MKSPAdd.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKSPAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *sp_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *sp_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *sp_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *sp_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *sp_custom;

- (void)sp_updateCharacterWithService:(CBService *)service;

- (void)sp_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)sp_connectSuccess;

- (void)sp_setNil;

@end

NS_ASSUME_NONNULL_END
