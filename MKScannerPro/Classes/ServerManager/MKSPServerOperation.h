//
//  MKSPServerOperation.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPServerTaskID.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKSPServerOperationProtocol <NSObject>

- (void)didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic;

@end

@interface MKSPServerOperation : NSOperation<MKSPServerOperationProtocol>

/**
 初始化通信线程
 
 @param operationID 当前线程的任务ID
 @param deviceID 当前任务的deviceID
 @param commandBlock 发送命令回调
 @param completeBlock 数据通信完成回调
 @return operation
 */
- (instancetype)initOperationWithID:(mk_sp_serverOperationID)operationID
                           deviceID:(NSString *)deviceID
                       commandBlock:(void (^)(void))commandBlock
                      completeBlock:(void (^)(NSError *error, id returnData))completeBlock;

@end

NS_ASSUME_NONNULL_END
