//
//  CBPeripheral+MKSPAdd.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKSPAdd.h"

#import <objc/runtime.h>

static const char *sp_hardwareKey = "sp_hardwareKey";
static const char *sp_firmwareKey = "sp_firmwareKey";

static const char *sp_passwordKey = "sp_passwordKey";
static const char *sp_disconnectTypeKey = "sp_disconnectTypeKey";
static const char *sp_customKey = "sp_customKey";

static const char *sp_passwordNotifySuccessKey = "sp_passwordNotifySuccessKey";
static const char *sp_disconnectTypeNotifySuccessKey = "sp_disconnectTypeNotifySuccessKey";
static const char *sp_customNotifySuccessKey = "sp_customNotifySuccessKey";

@implementation CBPeripheral (MKSPAdd)

- (void)sp_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &sp_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &sp_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &sp_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &sp_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &sp_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }
        return;
    }
}

- (void)sp_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &sp_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &sp_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &sp_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)sp_connectSuccess {
    if (![objc_getAssociatedObject(self, &sp_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &sp_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &sp_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.sp_hardware || !self.sp_firmware) {
        return NO;
    }
    if (!self.sp_password || !self.sp_disconnectType || !self.sp_custom) {
        return NO;
    }
    return YES;
}

- (void)sp_setNil {
    objc_setAssociatedObject(self, &sp_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sp_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &sp_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sp_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sp_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &sp_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sp_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sp_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)sp_hardware {
    return objc_getAssociatedObject(self, &sp_hardwareKey);
}

- (CBCharacteristic *)sp_firmware {
    return objc_getAssociatedObject(self, &sp_firmwareKey);
}

- (CBCharacteristic *)sp_password {
    return objc_getAssociatedObject(self, &sp_passwordKey);
}

- (CBCharacteristic *)sp_disconnectType {
    return objc_getAssociatedObject(self, &sp_disconnectTypeKey);
}

- (CBCharacteristic *)sp_custom {
    return objc_getAssociatedObject(self, &sp_customKey);
}

@end
