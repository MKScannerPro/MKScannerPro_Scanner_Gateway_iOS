//
//  MKSPAFilterConditionController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_spa_conditionType) {
    mk_spa_conditionType_A,
    mk_spa_conditionType_B,
};

@interface MKSPAFilterConditionController : MKSPBaseViewController

@property (nonatomic, assign)mk_spa_conditionType conditionType;

@end

NS_ASSUME_NONNULL_END
