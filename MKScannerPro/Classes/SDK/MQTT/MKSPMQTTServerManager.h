//
//  MKSPMQTTServerManager.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseMQTTModule/MKMQTTServerManager.h>

#import "MKSPServerConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MKSPMQTTSessionManagerStateChangedNotification;

@interface MKSPMQTTServerManager : NSObject<MKMQTTServerProtocol>

@property (nonatomic, assign, readonly)MKSPMQTTSessionManagerState state;

@property (nonatomic, strong, readonly, getter=currentServerParams)id <MKSPServerParamsProtocol>serverParams;

@property (nonatomic, strong, readonly)NSMutableArray <id <MKSPServerManagerProtocol>>*managerList;

+ (MKSPMQTTServerManager *)shared;

/// 销毁单例
+ (void)singleDealloc;

/// 将一个满足MKSPServerManagerProtocol的对象加入到管理列表
/// @param dataManager MKSPServerManagerProtocol
- (void)loadDataManager:(nonnull id <MKSPServerManagerProtocol>)dataManager;

/// 将满足MKSPServerManagerProtocol的对象移除管理列表
/// @param dataManager MKSPServerManagerProtocol的对象
- (BOOL)removeDataManager:(nonnull id <MKSPServerManagerProtocol>)dataManager;

/// 将参数保存到本地，下次启动通过该参数连接服务器
/// @param protocol protocol
- (BOOL)saveServerParams:(id <MKSPServerParamsProtocol>)protocol;

/**
 清除本地记录的设置信息
 */
- (BOOL)clearLocalData;

#pragma mark - *****************************服务器交互部分******************************

/// 开始连接服务器，前提是必须服务器参数不能为空
- (BOOL)connect;

- (void)disconnect;

/**
 Subscribe the topic

 @param topicList topicList
 */
- (void)subscriptions:(NSArray <NSString *>*)topicList;

/**
 Unsubscribe the topic
 
 @param topicList topicList
 */
- (void)unsubscriptions:(NSArray <NSString *>*)topicList;

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        sucBlock:(void (^)(void))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
