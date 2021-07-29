//
//  MKSPMQTTGeneralParamsView.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/12.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPMQTTGeneralParamsView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKTextField.h"

@interface UISegmentedControl (MKSPMQTTGeneralParamsViewAdd)
- (void)mk_setTintColor:(UIColor *)tintColor;
@end

@implementation UISegmentedControl (MKSPMQTTGeneralParamsViewAdd)
- (void)mk_setTintColor:(UIColor *)tintColor {
    // UISegmentedControl has changed in iOS 13 and setting the tint
    // color now has no effect.
    if (@available(iOS 13, *)) {
        UIImage *tintColorImage = [self imageWithColor:tintColor];
        // Must set the background image for normal to something (even clear) else the rest won't work

        [self setBackgroundImage:[self imageWithColor:self.backgroundColor ? self.backgroundColor : [UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:[self imageWithColor:[tintColor colorWithAlphaComponent:0.2]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor} forState:UIControlStateNormal];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        [self setDividerImage:tintColorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.layer.borderWidth = 1;
        self.layer.borderColor= [tintColor CGColor];
    }else {
        self.tintColor = tintColor;
    }
}

- (UIImage *)imageWithColor: (UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end

@implementation MKSPMQTTGeneralParamsViewModel
@end

@interface MKSPMQTTGeneralParamsView ()

@property (nonatomic, strong)UILabel *cleanLabel;

@property (nonatomic, strong)UIButton *cleanButton;

@property (nonatomic, strong)UILabel *qosLabel;

@property (nonatomic, strong)UISegmentedControl *segment;

@property (nonatomic, strong)UILabel *keepAliveLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@end

@implementation MKSPMQTTGeneralParamsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cleanLabel];
        [self addSubview:self.cleanButton];
        [self addSubview:self.qosLabel];
        [self addSubview:self.segment];
        [self addSubview:self.keepAliveLabel];
        [self addSubview:self.textField];
        [self addSubview:self.unitLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.cleanButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(40.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.cleanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.cleanButton.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.qosLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(self.cleanLabel.mas_width);
        make.centerY.mas_equalTo(self.segment.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.segment mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qosLabel.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.cleanButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.keepAliveLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(self.cleanLabel.mas_width);
        make.centerY.mas_equalTo(self.textField.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.textField.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qosLabel.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.top.mas_equalTo(self.segment.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(35.f);
    }];
}

#pragma mark - event method
- (void)cleanButtonPressed {
    self.cleanButton.selected = !self.cleanButton.selected;
    [self updateCleanButtonIcon];
    if ([self.delegate respondsToSelector:@selector(sp_mqtt_generalParams_cleanSessionStatusChanged:)]) {
        [self.delegate sp_mqtt_generalParams_cleanSessionStatusChanged:self.cleanButton.selected];
    }
}

- (void)segmentValueChanged {
    if ([self.delegate respondsToSelector:@selector(sp_mqtt_generalParams_qosChanged:)]) {
        [self.delegate sp_mqtt_generalParams_qosChanged:self.segment.selectedSegmentIndex];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKSPMQTTGeneralParamsViewModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKSPMQTTGeneralParamsViewModel.class]) {
        return;
    }
    self.cleanButton.selected = _dataModel.clean;
    self.segment.selectedSegmentIndex = _dataModel.qos;
    self.textField.text = _dataModel.keepAlive;
    [self updateCleanButtonIcon];
}

#pragma mark - private method
- (void)updateCleanButtonIcon {
    UIImage *image = (self.cleanButton.selected ? LOADICON(@"MKScannerPro", @"MKSPMQTTGeneralParamsView", @"sp_switchSelectedIcon.png") : LOADICON(@"MKScannerPro", @"MKSPMQTTGeneralParamsView", @"sp_switchUnselectedIcon.png"));
    [self.cleanButton setImage:image forState:UIControlStateNormal];
}

#pragma mark - getter
- (UILabel *)cleanLabel {
    if (!_cleanLabel) {
        _cleanLabel = [[UILabel alloc] init];
        _cleanLabel.textColor = DEFAULT_TEXT_COLOR;
        _cleanLabel.textAlignment = NSTextAlignmentLeft;
        _cleanLabel.font = MKFont(14.f);
        _cleanLabel.text = @"Clean Session";
    }
    return _cleanLabel;
}

- (UIButton *)cleanButton {
    if (!_cleanButton) {
        _cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cleanButton setImage:LOADICON(@"MKScannerPro", @"MKSPMQTTGeneralParamsView", @"sp_switchUnselectedIcon.png") forState:UIControlStateNormal];
        [_cleanButton addTarget:self
                         action:@selector(cleanButtonPressed)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanButton;
}

- (UILabel *)qosLabel {
    if (!_qosLabel) {
        _qosLabel = [[UILabel alloc] init];
        _qosLabel.textColor = DEFAULT_TEXT_COLOR;
        _qosLabel.textAlignment = NSTextAlignmentLeft;
        _qosLabel.font = MKFont(14.f);
        _qosLabel.text = @"Qos";
    }
    return _qosLabel;
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"0",@"1",@"2"]];
        [_segment mk_setTintColor:NAVBAR_COLOR_MACROS];
        _segment.selectedSegmentTintColor = COLOR_WHITE_MACROS;
        _segment.selectedSegmentIndex = 1;
        [_segment addTarget:self
                     action:@selector(segmentValueChanged)
           forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

- (UILabel *)keepAliveLabel {
    if (!_keepAliveLabel) {
        _keepAliveLabel = [[UILabel alloc] init];
        _keepAliveLabel.textColor = DEFAULT_TEXT_COLOR;
        _keepAliveLabel.textAlignment = NSTextAlignmentLeft;
        _keepAliveLabel.font = MKFont(14.f);
        _keepAliveLabel.text = @"Keep Alive";
    }
    return _keepAliveLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [[MKTextField alloc] initWithTextFieldType:mk_realNumberOnly];
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(sp_mqtt_generalParams_KeepAliveChanged:)]) {
                [self.delegate sp_mqtt_generalParams_KeepAliveChanged:text];
            }
        };
        _textField.maxLength = 3;
        _textField.placeholder = @"10-120";
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
        _unitLabel.text = @"s";
    }
    return _unitLabel;
}

@end
