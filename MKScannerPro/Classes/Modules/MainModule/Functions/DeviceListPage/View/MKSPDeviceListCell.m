//
//  MKSPDeviceListCell.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPDeviceListCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKSPDeviceModel.h"

@interface MKSPDeviceListCell ()

@property (nonatomic, strong)UILabel *deviceNameLabel;

@property (nonatomic, strong)UILabel *stateLabel;

@property (nonatomic, strong)UILabel *macLabel;

@property (nonatomic, strong)UIImageView *rightIcon;

@end

@implementation MKSPDeviceListCell

+ (MKSPDeviceListCell *)initCellWithTableView:(UITableView *)tableView {
    MKSPDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKSPDeviceListCellIdenty"];
    if (!cell) {
        cell = [[MKSPDeviceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKSPDeviceListCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.deviceNameLabel];
        [self.contentView addSubview:self.stateLabel];
        [self.contentView addSubview:self.macLabel];
        [self.contentView addSubview:self.rightIcon];
        [self addLongPressEventAction];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(8.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(14.f);
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightIcon.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.stateLabel.mas_left).mas_offset(-5.f);
        make.top.mas_equalTo(5.f);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.macLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.stateLabel.mas_left).mas_offset(-5.f);
        make.bottom.mas_equalTo(-5.f);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)longPressEventAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan && [self.delegate respondsToSelector:@selector(sp_cellDeleteButtonPressed:)]) {
        [self.delegate sp_cellDeleteButtonPressed:self.indexPath.row];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKSPDeviceModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKSPDeviceModel.class]) {
        return;
    }
    self.deviceNameLabel.text = SafeStr(_dataModel.deviceName);
    self.stateLabel.text = (_dataModel.onLineState == MKSPDeviceModelStateOnline ? @"Online" : @"Offline");
    self.stateLabel.textColor = (_dataModel.onLineState == MKSPDeviceModelStateOnline ? NAVBAR_COLOR_MACROS : UIColorFromRGB(0xcccccc));
    self.macLabel.text = SafeStr(_dataModel.macAddress);
}

#pragma mark - private method
- (void)addLongPressEventAction {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    [longPress addTarget:self action:@selector(longPressEventAction:)];
    [self.contentView addGestureRecognizer:longPress];
}

#pragma mark - getter

- (UILabel *)deviceNameLabel {
    if (!_deviceNameLabel) {
        _deviceNameLabel = [[UILabel alloc] init];
        _deviceNameLabel.textColor = DEFAULT_TEXT_COLOR;
        _deviceNameLabel.textAlignment = NSTextAlignmentLeft;
        _deviceNameLabel.font = MKFont(14.f);
    }
    return _deviceNameLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textColor = UIColorFromRGB(0xcccccc);
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.font = MKFont(12.f);
        _stateLabel.text = @"Offline";
    }
    return _stateLabel;
}

- (UILabel *)macLabel {
    if (!_macLabel) {
        _macLabel = [[UILabel alloc] init];
        _macLabel.textAlignment = NSTextAlignmentLeft;
        _macLabel.textColor = UIColorFromRGB(0xcccccc);
        _macLabel.font = MKFont(12.f);
    }
    return _macLabel;
}

- (UIImageView *)rightIcon {
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc] init];
        _rightIcon.image = LOADICON(@"MKScannerPro", @"MKSPDeviceListCell", @"sp_goNextButton.png");
    }
    return _rightIcon;
}

@end
