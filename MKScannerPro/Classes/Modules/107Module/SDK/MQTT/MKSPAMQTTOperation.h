//
//  MKSPAMQTTOperation.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPAMQTTTaskID.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKSPAMQTTOperationProtocol <NSObject>

- (void)didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic;

@end

@interface MKSPAMQTTOperation : NSOperation<MKSPAMQTTOperationProtocol>

/**
 初始化通信线程
 
 @param operationID 当前线程的任务ID
 @param deviceID 当前任务的deviceID
 @param commandBlock 发送命令回调
 @param completeBlock 数据通信完成回调
 @return operation
 */
- (instancetype)initOperationWithID:(mk_spa_serverOperationID)operationID
                           deviceID:(NSString *)deviceID
                       commandBlock:(void (^)(void))commandBlock
                      completeBlock:(void (^)(NSError *error, id returnData))completeBlock;

@end

NS_ASSUME_NONNULL_END
