//
//  MKSPDeviceServerDatabase.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/19.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPDeviceServerDatabase.h"

#import <FMDB/FMDB.h>

#import "MKMacroDefines.h"

@implementation MKSPDeviceServerDatabase

+ (BOOL)initDataBase {
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"SPDeviceServerDB")];
    if (![db open]) {
        return NO;
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"create table if not exists SPDeviceServerTable (deviceID text,type text,host text,port text,cleanSession text,userName text,password text,qos text,keepAlive text,subscribedTopic text,publishedTopic text)"];
    BOOL resCreate = [db executeUpdate:sqlCreateTable];
    if (!resCreate) {
        [db close];
        return NO;
    }
    return YES;
}

+ (void)insertDataList:(NSArray <NSDictionary *>*)dataList
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    if (!dataList) {
        [self operationInsertFailedBlock:failedBlock];
        return ;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"SPDeviceServerDB")];
    if (![db open]) {
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"create table if not exists SPDeviceServerTable (deviceID text,type text,host text,port text,cleanSession text,userName text,password text,qos text,keepAlive text,subscribedTopic text,publishedTopic text)"];
    BOOL resCreate = [db executeUpdate:sqlCreateTable];
    if (!resCreate) {
        [db close];
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"SPDeviceServerDB")] inDatabase:^(FMDatabase *db) {
        
        for (NSDictionary *dic in dataList) {
            BOOL exist = NO;
            FMResultSet * result = [db executeQuery:@"select * from SPDeviceServerTable where deviceID = ?",dic[@"deviceID"]];
            while (result.next) {
                if ([dic[@"deviceID"] isEqualToString:[result stringForColumn:@"deviceID"]]) {
                    exist = YES;
                }
            }
            if (exist) {
                //存在该设备，更新设备
                [db executeUpdate:@"UPDATE SPDeviceServerTable SET type = ?, host = ?, port = ? ,cleanSession = ? ,userName = ? ,password = ?, qos = ?, keepAlive = ?, subscribedTopic = ?, publishedTopic = ?  WHERE deviceID = ?",SafeStr(dic[@"type"]),SafeStr(dic[@"host"]),SafeStr(dic[@"port"]),SafeStr(dic[@"cleanSession"]),SafeStr(dic[@"userName"]),SafeStr(dic[@"password"]),SafeStr(dic[@"qos"]),SafeStr(dic[@"keepAlive"]),SafeStr(dic[@"subscribedTopic"]),SafeStr(dic[@"publishedTopic"]),SafeStr(dic[@"deviceID"])];
            }else{
                //不存在，插入设备
                [db executeUpdate:@"INSERT INTO SPDeviceServerTable (deviceID,type,host,port,cleanSession,userName,password,qos,keepAlive,subscribedTopic,publishedTopic) VALUES (?,?,?,?,?,?,?,?,?,?,?)",SafeStr(dic[@"deviceID"]),SafeStr(dic[@"type"]),SafeStr(dic[@"host"]),SafeStr(dic[@"port"]),SafeStr(dic[@"cleanSession"]),SafeStr(dic[@"userName"]),SafeStr(dic[@"password"]),SafeStr(dic[@"qos"]),SafeStr(dic[@"keepAlive"]),SafeStr(dic[@"subscribedTopic"]),SafeStr(dic[@"publishedTopic"])];
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

+ (void)deleteDataWithDeviceID:(NSString *)deviceID
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(deviceID)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"SPDeviceServerDB")] inDatabase:^(FMDatabase *db) {
        
        BOOL result = [db executeUpdate:@"DELETE FROM SPDeviceServerTable WHERE deviceID = ?",deviceID];
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

+ (void)readDataWithDeviceID:(NSString *)deviceID
                    sucBlock:(void (^)(NSDictionary *params))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(deviceID)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"SPDeviceServerDB")];
    if (![db open]) {
        [self operationGetDataFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"SPDeviceServerDB")] inDatabase:^(FMDatabase *db) {
        NSDictionary *resultDic = @{};
        FMResultSet * result = [db executeQuery:@"SELECT * FROM SPDeviceServerTable WHERE deviceID = ?",deviceID];
        
        while ([result next]) {
            resultDic = @{
                @"deviceID":SafeStr([result stringForColumn:@"deviceID"]),
                @"type":SafeStr([result stringForColumn:@"type"]),
                @"host":SafeStr([result stringForColumn:@"host"]),
                @"port":SafeStr([result stringForColumn:@"port"]),
                @"cleanSession":SafeStr([result stringForColumn:@"cleanSession"]),
                @"userName":SafeStr([result stringForColumn:@"userName"]),
                @"password":SafeStr([result stringForColumn:@"password"]),
                @"qos":SafeStr([result stringForColumn:@"qos"]),
                @"keepAlive":SafeStr([result stringForColumn:@"keepAlive"]),
                @"subscribedTopic":SafeStr([result stringForColumn:@"subscribedTopic"]),
                @"publishedTopic":SafeStr([result stringForColumn:@"publishedTopic"])
            };
        }
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock(resultDic);
            });
        }
        [db close];
    }];
}

#pragma mark - private method

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
