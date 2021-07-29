//
//  MKSPFilterConditionController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_sp_conditionType) {
    mk_sp_conditionType_A,
    mk_sp_conditionType_B,
};

@class MKSPDeviceModel;
@interface MKSPFilterConditionController : MKBaseViewController

@property (nonatomic, assign)mk_sp_conditionType conditionType;

@property (nonatomic, strong)MKSPDeviceModel *deviceModel;

@end

NS_ASSUME_NONNULL_END
