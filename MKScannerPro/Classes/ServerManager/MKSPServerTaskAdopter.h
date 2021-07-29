//
//  MKSPServerTaskAdopter.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/18.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPServerTaskAdopter : NSObject

+ (NSDictionary *)parseDataWithJson:(NSDictionary *)json topic:(NSString *)topic;

@end

NS_ASSUME_NONNULL_END
