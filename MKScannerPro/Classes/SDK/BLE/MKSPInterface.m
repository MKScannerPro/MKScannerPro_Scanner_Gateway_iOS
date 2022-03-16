//
//  MKSPInterface.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPInterface.h"

#import "MKSPCentralManager.h"
#import "MKSPOperationID.h"
#import "MKSPOperation.h"
#import "CBPeripheral+MKSPAdd.h"

#define centralManager [MKSPCentralManager shared]
#define peripheral ([MKSPCentralManager shared].peripheral)

@implementation MKSPInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)sp_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_sp_taskReadFirmwareOperation
                           characteristic:peripheral.sp_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)sp_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_sp_taskReadHardwareOperation
                           characteristic:peripheral.sp_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark ****************************************自定义协议读取************************************************

+ (void)sp_readWIFISSIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000200";
    [centralManager addTaskWithTaskID:mk_sp_taskReadWIFISSIDOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readWIFIPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000300";
    [centralManager addTaskWithTaskID:mk_sp_taskReadWIFIPasswordOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readConnectModeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000400";
    [centralManager addTaskWithTaskID:mk_sp_taskReadConnectModeOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000500";
    [centralManager addTaskWithTaskID:mk_sp_taskReadServerHostOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readServerPortWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000600";
    [centralManager addTaskWithTaskID:mk_sp_taskReadServerPortOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readServerCleanSessionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000700";
    [centralManager addTaskWithTaskID:mk_sp_taskReadServerCleanSessionOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readServerKeepAliveWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000800";
    [centralManager addTaskWithTaskID:mk_sp_taskReadServerKeepAliveOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readServerQosWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000900";
    [centralManager addTaskWithTaskID:mk_sp_taskReadServerQosOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readClientIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000a00";
    [centralManager addTaskWithTaskID:mk_sp_taskReadClientIDOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readDeviceIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000b00";
    [centralManager addTaskWithTaskID:mk_sp_taskReadDeviceIDOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readSubscibeTopicWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000c00";
    [centralManager addTaskWithTaskID:mk_sp_taskReadSubscibeTopicOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readPublishTopicWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000d00";
    [centralManager addTaskWithTaskID:mk_sp_taskReadPublishTopicOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readNTPServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000e00";
    [centralManager addTaskWithTaskID:mk_sp_taskReadNTPServerHostOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000f00";
    [centralManager addTaskWithTaskID:mk_sp_taskReadTimeZoneOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readDeviceMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001000";
    [centralManager addTaskWithTaskID:mk_sp_taskReadDeviceMacAddressOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSString *commandString = @"ed001100";
    [centralManager addTaskWithTaskID:mk_sp_taskReadDeviceNameOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readDeviceTypeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001700";
    [centralManager addTaskWithTaskID:mk_sp_taskReadDeviceTypeOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)sp_readChannelWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001a00";
    [centralManager addTaskWithTaskID:mk_sp_taskReadChannelOperation
                       characteristic:peripheral.sp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
