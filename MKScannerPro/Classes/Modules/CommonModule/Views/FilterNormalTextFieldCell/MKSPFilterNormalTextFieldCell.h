//
//  MKSPFilterNormalTextFieldCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

#import <MKCustomUIModule/MKTextField.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPFilterNormalTextFieldCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

/// 左侧msg
@property (nonatomic, copy)NSString *msg;

/// 当前textField的值
@property (nonatomic, copy)NSString *textFieldValue;

/// textField的占位符
@property (nonatomic, copy)NSString *textPlaceholder;

/// 当前textField的输入类型
@property (nonatomic, assign)mk_textFieldType textFieldType;

/// textField的最大输入长度,对于textFieldType == mk_uuidMode无效
@property (nonatomic, assign)NSInteger maxLength;

@end

@protocol MKSPFilterNormalTextFieldCellDelegate <NSObject>

- (void)mk_sp_filterNormalTextFieldValueChanged:(NSString *)text index:(NSInteger)index;

@end

@interface MKSPFilterNormalTextFieldCell : MKBaseCell

@property (nonatomic, strong)MKSPFilterNormalTextFieldCellModel *dataModel;

@property (nonatomic, weak)id <MKSPFilterNormalTextFieldCellDelegate>delegate;

+ (MKSPFilterNormalTextFieldCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
