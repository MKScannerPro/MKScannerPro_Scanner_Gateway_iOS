//
//  MKSPAUploadOptionModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPAUploadOptionModel : NSObject

@property (nonatomic, assign)BOOL beaconDataFilter;

@property (nonatomic, assign)BOOL filterConditionA;

@property (nonatomic, assign)BOOL filterConditionB;

/// 0:And,1:Or
@property (nonatomic, assign)NSInteger conditionIndex;

@end

NS_ASSUME_NONNULL_END
