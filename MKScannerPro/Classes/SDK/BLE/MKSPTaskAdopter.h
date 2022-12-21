//
//  MKSPTaskAdopter.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const mk_sp_totalNumKey;
extern NSString *const mk_sp_totalIndexKey;
extern NSString *const mk_sp_contentKey;

@class CBCharacteristic;
@interface MKSPTaskAdopter : NSObject

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic;

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic;

@end

NS_ASSUME_NONNULL_END
