//
//  MKSPDeviceDataTableHeaderView.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPDeviceDataTableHeaderView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"
#import "MKTextField.h"

@implementation MKSPDeviceDataTableHeaderViewModel
@end

@interface MKSPDeviceDataTableHeaderView ()

@property (nonatomic, strong)UIButton *uploadButton;

@property (nonatomic, strong)UILabel *scannerLabel;

@property (nonatomic, strong)UIButton *scannerButton;

@property (nonatomic, strong)UILabel *scanTimeLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)UIButton *saveButton;

@property (nonatomic, strong)UILabel *totalLabel;

@end

@implementation MKSPDeviceDataTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.uploadButton];
        [self addSubview:self.scannerLabel];
        [self addSubview:self.scannerButton];
        [self addSubview:self.scanTimeLabel];
        [self addSubview:self.textField];
        [self addSubview:self.unitLabel];
        [self addSubview:self.saveButton];
        [self addSubview:self.totalLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(40.f);
    }];
    [self.scannerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(40.f);
        make.top.mas_equalTo(self.uploadButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.scannerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.scannerButton.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(40.f);
        make.top.mas_equalTo(self.scannerButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.scanTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.saveButton.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scanTimeLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.saveButton.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textField.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.saveButton.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.saveButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)uploadButtonPressed {
    if ([self.delegate respondsToSelector:@selector(sp_updateLoadButtonAction)]) {
        [self.delegate sp_updateLoadButtonAction];
    }
}

- (void)scannerButtonPressed {
    if ([self.delegate respondsToSelector:@selector(sp_scannerStatusChanged:)]) {
        [self.delegate sp_scannerStatusChanged:!self.scannerButton.selected];
    }
}

- (void)saveButtonPressed {
    if ([self.delegate respondsToSelector:@selector(sp_saveButtonAction)]) {
        [self.delegate sp_saveButtonAction];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKSPDeviceDataTableHeaderViewModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKSPDeviceDataTableHeaderViewModel.class]) {
        return;
    }
    self.scannerButton.selected = _dataModel.isOn;
    self.textField.text = SafeStr(_dataModel.scanTime);
    self.totalLabel.text = [NSString stringWithFormat:@"Total %ld pieces of data",(long)_dataModel.totalNum];
    [self reloadSubViews];
}

#pragma mark - private method
- (void)reloadSubViews {
    UIImage *image = (self.scannerButton.selected ? LOADICON(@"MKScannerPro", @"MKSPDeviceDataTableHeaderView", @"sp_switchSelectedIcon.png") : LOADICON(@"MKScannerPro", @"MKSPDeviceDataTableHeaderView", @"sp_switchUnselectedIcon.png"));
    [self.scannerButton setImage:image forState:UIControlStateNormal];
    self.scanTimeLabel.hidden = !self.scannerButton.selected;
    self.textField.hidden = !self.scannerButton.selected;
    self.unitLabel.hidden = !self.scannerButton.selected;
    self.saveButton.hidden = !self.scannerButton.selected;
    self.totalLabel.hidden = !self.scannerButton.selected;
}

#pragma mark - getter
- (UIButton *)uploadButton {
    if (!_uploadButton) {
        _uploadButton = [MKCustomUIAdopter customButtonWithTitle:@"Scanner and upload option"
                                                          target:self
                                                          action:@selector(uploadButtonPressed)];
    }
    return _uploadButton;
}

- (UILabel *)scannerLabel {
    if (!_scannerLabel) {
        _scannerLabel = [[UILabel alloc] init];
        _scannerLabel.textColor = DEFAULT_TEXT_COLOR;
        _scannerLabel.textAlignment = NSTextAlignmentLeft;
        _scannerLabel.font = MKFont(14.f);
        _scannerLabel.text = @"Scanner";
    }
    return _scannerLabel;
}

- (UIButton *)scannerButton {
    if (!_scannerButton) {
        _scannerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scannerButton addTarget:self
                           action:@selector(scannerButtonPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _scannerButton;
}

- (UILabel *)scanTimeLabel {
    if (!_scanTimeLabel) {
        _scanTimeLabel = [[UILabel alloc] init];
        _scanTimeLabel.textAlignment = NSTextAlignmentLeft;
        _scanTimeLabel.textColor = DEFAULT_TEXT_COLOR;
        _scanTimeLabel.font = MKFont(14.f);
        _scanTimeLabel.text = @"Scan Time";
    }
    return _scanTimeLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [[MKTextField alloc] initWithTextFieldType:mk_realNumberOnly];
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(sp_scannerTimeChanged:)]) {
                [self.delegate sp_scannerTimeChanged:text];
            }
        };
        _textField.maxLength = 5;
        _textField.placeholder = @"10-65535";
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.font = MKFont(13.f);
        
        _textField.backgroundColor = COLOR_WHITE_MACROS;
        _textField.layer.masksToBounds = YES;
        _textField.layer.borderWidth = CUTTING_LINE_HEIGHT;
        _textField.layer.borderColor = CUTTING_LINE_COLOR.CGColor;
        _textField.layer.cornerRadius = 6.f;
    }
    return _textField;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.font = MKFont(13.f);
        _unitLabel.text = @"S";
    }
    return _unitLabel;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [MKCustomUIAdopter customButtonWithTitle:@"Save"
                                                        target:self
                                                        action:@selector(saveButtonPressed)];
    }
    return _saveButton;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.textColor = DEFAULT_TEXT_COLOR;
        _totalLabel.textAlignment = NSTextAlignmentLeft;
        _totalLabel.font = MKFont(14.f);
        _totalLabel.text = @"Total 0 pieces of data";
    }
    return _totalLabel;
}

@end
