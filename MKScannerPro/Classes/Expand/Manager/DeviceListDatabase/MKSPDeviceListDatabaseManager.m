//
//  MKSPDeviceListDatabaseManager.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPDeviceListDatabaseManager.h"

#import <FMDB/FMDB.h>

#import "MKMacroDefines.h"

#import "MKSPDeviceModel.h"

@implementation MKSPDeviceListDatabaseManager

+ (BOOL)initDataBase {
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"SPDeviceDB")];
    if (![db open]) {
        return NO;
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"create table if not exists SPDeviceTable (deviceID text,clientID text,deviceName text,subscribedTopic text,publishedTopic text,macAddress text)"];
    BOOL resCreate = [db executeUpdate:sqlCreateTable];
    if (!resCreate) {
        [db close];
        return NO;
    }
    return YES;
}

+ (void)insertDeviceList:(NSArray <MKSPDeviceModel *>*)deviceList
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!deviceList) {
        [self operationInsertFailedBlock:failedBlock];
        return ;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"SPDeviceDB")];
    if (![db open]) {
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"create table if not exists SPDeviceTable (deviceID text,clientID text,deviceName text,subscribedTopic text,publishedTopic text,macAddress text)"];
    BOOL resCreate = [db executeUpdate:sqlCreateTable];
    if (!resCreate) {
        [db close];
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"SPDeviceDB")] inDatabase:^(FMDatabase *db) {
        
        for (MKSPDeviceModel *device in deviceList) {
            BOOL exist = NO;
            FMResultSet * result = [db executeQuery:@"select * from SPDeviceTable where deviceID = ?",device.deviceID];
            while (result.next) {
                if ([device.deviceID isEqualToString:[result stringForColumn:@"deviceID"]]) {
                    exist = YES;
                }
            }
            if (exist) {
                //存在该设备，更新设备
                [db executeUpdate:@"UPDATE SPDeviceTable SET macAddress = ?, clientID = ?, deviceName = ? ,subscribedTopic = ? ,publishedTopic = ? WHERE deviceID = ?",SafeStr(device.macAddress),SafeStr(device.clientID),SafeStr(device.deviceName),SafeStr(device.subscribedTopic),SafeStr(device.publishedTopic),SafeStr(device.deviceID)];
            }else{
                //不存在，插入设备
                [db executeUpdate:@"INSERT INTO SPDeviceTable (deviceID,clientID,deviceName,subscribedTopic,publishedTopic,macAddress) VALUES (?,?,?,?,?,?)",SafeStr(device.deviceID),SafeStr(device.clientID),SafeStr(device.deviceName),SafeStr(device.subscribedTopic),SafeStr(device.publishedTopic),SafeStr(device.macAddress)];
            }
        }
        
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock();
            });
        }
        [db close];
    }];
}

+ (void)deleteDeviceWithDeviceID:(NSString *)deviceID
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(deviceID)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"SPDeviceDB")] inDatabase:^(FMDatabase *db) {
        
        BOOL result = [db executeUpdate:@"DELETE FROM SPDeviceTable WHERE deviceID = ?",deviceID];
        if (!result) {
            [self operationDeleteFailedBlock:failedBlock];
            return;
        }
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock();
            });
        }
        [db close];
    }];
}

+ (void)readLocalDeviceWithSucBlock:(void (^)(NSArray <MKSPDeviceModel *> *deviceList))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"SPDeviceDB")];
    if (![db open]) {
        [self operationGetDataFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"SPDeviceDB")] inDatabase:^(FMDatabase *db) {
        NSMutableArray *tempDataList = [NSMutableArray array];
        FMResultSet * result = [db executeQuery:@"SELECT * FROM SPDeviceTable"];
        while ([result next]) {
            MKSPDeviceModel *dataModel = [[MKSPDeviceModel alloc] init];
            dataModel.deviceID = [result stringForColumn:@"deviceID"];
            dataModel.clientID = [result stringForColumn:@"clientID"];
            dataModel.deviceName = [result stringForColumn:@"deviceName"];
            dataModel.subscribedTopic = [result stringForColumn:@"subscribedTopic"];
            dataModel.publishedTopic = [result stringForColumn:@"publishedTopic"];
            dataModel.macAddress = [result stringForColumn:@"macAddress"];
        
            [tempDataList addObject:dataModel];
        }
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock(tempDataList);
            });
        }
        [db close];
    }];
}

+ (void)operationFailedBlock:(void (^)(NSError *error))block msg:(NSString *)msg{
    if (block) {
        NSError *error = [[NSError alloc] initWithDomain:@"com.moko.databaseOperation"
                                                    code:-111111
                                                userInfo:@{@"errorInfo":msg}];
        moko_dispatch_main_safe(^{
            block(error);
        });
    }
}

+ (void)operationInsertFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"insert data error"];
}

+ (void)operationUpdateFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"update data error"];
}

+ (void)operationDeleteFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"fail to delete"];
}

+ (void)operationGetDataFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"get data error"];
}

@end
