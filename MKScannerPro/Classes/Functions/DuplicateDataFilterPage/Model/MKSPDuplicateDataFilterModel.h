//
//  MKSPDuplicateDataFilterModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPDuplicateDataFilterModel : NSObject

@property (nonatomic, copy)NSString *interval;

/// 0 : None    1 :  MAC    2 : MAC+Data type    3 : MAC+Raw data
@property (nonatomic, assign)NSInteger filterType;

@end

NS_ASSUME_NONNULL_END
