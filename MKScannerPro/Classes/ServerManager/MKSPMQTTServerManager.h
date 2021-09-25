//
//  MKSPMQTTServerManager.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/9/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPMQTTServerParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPMQTTServerManager : NSObject

/// 当前服务器参数
@property (nonatomic, strong, readonly, getter=currentServerParams)id <MKSPMQTTServerParamsProtocol>serverParams;

+ (MKSPMQTTServerManager *)shared;

/// 将参数保存到本地，下次启动通过该参数连接服务器
/// @param protocol protocol
- (BOOL)saveServerParams:(id <MKSPMQTTServerParamsProtocol>)protocol;

/**
 清除本地记录的设置信息
 */
- (BOOL)clearLocalData;

#pragma mark - *****************************服务器交互部分******************************

/// 开始连接服务器，前提是必须服务器参数不能为空
- (BOOL)connect;

@end

NS_ASSUME_NONNULL_END
