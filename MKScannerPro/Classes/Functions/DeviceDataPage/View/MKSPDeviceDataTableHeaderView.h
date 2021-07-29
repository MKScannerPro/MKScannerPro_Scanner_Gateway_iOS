//
//  MKSPDeviceDataTableHeaderView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPDeviceDataTableHeaderViewModel : NSObject

@property (nonatomic, copy)NSString *scanTime;

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)NSInteger totalNum;

@end

@protocol MKSPDeviceDataTableHeaderViewDelegate <NSObject>

- (void)sp_updateLoadButtonAction;

- (void)sp_scannerStatusChanged:(BOOL)isOn;

- (void)sp_scannerTimeChanged:(NSString *)time;

- (void)sp_saveButtonAction;

@end

@interface MKSPDeviceDataTableHeaderView : UIView

@property (nonatomic, weak)id <MKSPDeviceDataTableHeaderViewDelegate>delegate;

@property (nonatomic, strong)MKSPDeviceDataTableHeaderViewModel *dataModel;

@end

NS_ASSUME_NONNULL_END
