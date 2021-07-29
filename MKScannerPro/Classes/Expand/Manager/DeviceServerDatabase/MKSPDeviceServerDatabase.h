//
//  MKSPDeviceServerDatabase.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/19.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPDeviceServerDatabase : NSObject

/// 创建数据库
+ (BOOL)initDataBase;

/// 设备入库，key为deviceID地址，如果本地已经存在则覆盖，不存在则插入
/// @param dataList 设备列表
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)insertDataList:(NSArray <NSDictionary *>*)dataList
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

+ (void)deleteDataWithDeviceID:(NSString *)deviceID
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取设备的服务器信息
/// @param deviceID deviceID
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)readDataWithDeviceID:(NSString *)deviceID
                    sucBlock:(void (^)(NSDictionary *params))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
