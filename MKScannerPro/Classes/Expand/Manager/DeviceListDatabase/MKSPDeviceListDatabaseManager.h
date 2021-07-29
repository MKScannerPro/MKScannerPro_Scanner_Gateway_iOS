//
//  MKSPDeviceListDatabaseManager.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MKSPDeviceModel;
@interface MKSPDeviceListDatabaseManager : NSObject

/// 创建数据库
+ (BOOL)initDataBase;

/// 设备入库，key为deviceID地址，如果本地已经存在则覆盖，不存在则插入
/// @param deviceList 设备列表
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)insertDeviceList:(NSArray <MKSPDeviceModel *>*)deviceList
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

+ (void)deleteDeviceWithDeviceID:(NSString *)deviceID
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

+ (void)readLocalDeviceWithSucBlock:(void (^)(NSArray <MKSPDeviceModel *> *deviceList))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
