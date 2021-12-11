//
//  MKSPFilterNormalTextFieldCell.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPFilterNormalTextFieldCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

@implementation MKSPFilterNormalTextFieldCellModel
@end

@interface MKSPFilterNormalTextFieldCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *textField;

@end

@implementation MKSPFilterNormalTextFieldCell

+ (MKSPFilterNormalTextFieldCell *)initCellWithTableView:(UITableView *)tableView {
    MKSPFilterNormalTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKSPFilterNormalTextFieldCellIdenty"];
    if (!cell) {
        cell = [[MKSPFilterNormalTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKSPFilterNormalTextFieldCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(5.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKSPFilterNormalTextFieldCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKSPFilterNormalTextFieldCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.textField.textType = _dataModel.textFieldType;
    self.textField.placeholder = SafeStr(_dataModel.textPlaceholder);
    self.textField.text = SafeStr(_dataModel.textFieldValue);
    self.textField.maxLength = _dataModel.maxLength;
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                          placeHolder:@""
                                                             textType:mk_realNumberOnly];
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(mk_sp_filterNormalTextFieldValueChanged:index:)]) {
                [self.delegate mk_sp_filterNormalTextFieldValueChanged:text index:self.dataModel.index];
            }
        };
    }
    return _textField;
}

@end
