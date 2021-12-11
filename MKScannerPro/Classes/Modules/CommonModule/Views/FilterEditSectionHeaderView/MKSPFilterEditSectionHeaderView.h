//
//  MKSPFilterEditSectionHeaderView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKSPFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_sp_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_sp_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKSPFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKSPFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKSPFilterEditSectionHeaderViewDelegate>delegate;

+ (MKSPFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
