//
//  MKSPPDFUModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/8.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPDFUModel : NSObject

/// dfu从机固件
/// @param fileName 固件在本地的名字
/// @param macAddress 要升级的从机mac地址
/// @param progressBlock 升级进度
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)updateWithFileName:(NSString *)fileName
               macAddress:(NSString *)macAddress
            progressBlock:(void (^)(CGFloat progress))progressBlock
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
