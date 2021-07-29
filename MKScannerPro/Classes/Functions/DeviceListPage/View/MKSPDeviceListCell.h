//
//  MKSPDeviceListCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKSPDeviceListCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)sp_cellDeleteButtonPressed:(NSInteger)index;

/**
 重新设置cell的子控件位置，主要是删除按钮方面的处理
 */
- (void)sp_cellResetFrame;


/// cell的点击事件，用来重置cell的布局
/// @param index 所在index
- (void)sp_cellTapAction:(NSInteger)index;

@end

@class MKSPDeviceModel;
@interface MKSPDeviceListCell : MKBaseCell

@property (nonatomic, weak)id <MKSPDeviceListCellDelegate>delegate;

@property (nonatomic, strong)MKSPDeviceModel *dataModel;

+ (MKSPDeviceListCell *)initCellWithTableView:(UITableView *)tableView;

- (BOOL)canReset;
- (void)resetCellFrame;
- (void)resetFlagForFrame;

@end

NS_ASSUME_NONNULL_END
