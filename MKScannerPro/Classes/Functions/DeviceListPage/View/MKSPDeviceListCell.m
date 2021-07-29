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

static CGFloat const deleteButtonWidth = 75.0f;
static CGFloat const offset = 15.f;
static CGFloat const rightIconWidth = 8.f;
static CGFloat const rightIconHeight = 14.f;
static CGFloat const stateLabelWidth = 40.f;

@interface MKSPDeviceListCell ()

/**
 所有标签都位于这个上面
 */
@property (nonatomic, strong)UIView *contentPanel;

@property (nonatomic, strong)UIView *deleteBackView;

@property (nonatomic, strong)UIButton *deleteButton;

@property (nonatomic, strong)UILabel *deviceNameLabel;

@property (nonatomic, strong)UILabel *stateLabel;

@property (nonatomic, strong)UILabel *macLabel;

@property (nonatomic, strong)UIImageView *rightIcon;

@property (nonatomic, strong)UIView *lineView;

/**
 是否需要重新设置cell子控件坐标，
 */
@property (nonatomic, assign)BOOL shouldSetFrame;

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
        [self.contentView addSubview:self.deleteBackView];
        [self.contentView addSubview:self.contentPanel];
        
        [self.contentPanel addSubview:self.deviceNameLabel];
        [self.contentPanel addSubview:self.stateLabel];
        [self.contentPanel addSubview:self.macLabel];
        [self.contentPanel addSubview:self.rightIcon];
        [self.contentPanel addSubview:self.lineView];
        
        [self.deleteBackView addSubview:self.deleteButton];
        [self addSwipeRecognizer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentPanel setFrame:self.contentView.bounds];
    [self.deleteBackView setFrame:self.contentView.bounds];
    
    [self.deleteButton setFrame:CGRectMake(self.contentView.frame.size.width - deleteButtonWidth,
                                              0,
                                              deleteButtonWidth,
                                           self.contentView.frame.size.height)];
    
    CGFloat rightIconLeftPostion = self.contentView.frame.size.width - offset - rightIconWidth;
    [self.rightIcon setFrame:CGRectMake(rightIconLeftPostion,
                                        (self.contentView.frame.size.height - 14.f) / 2,
                                        rightIconWidth,
                                        rightIconHeight)];
    
    CGFloat stateLabelLeftPostion = rightIconLeftPostion - 10.f - stateLabelWidth;
    [self.stateLabel setFrame:CGRectMake(stateLabelLeftPostion,
                                         (self.contentView.frame.size.height - MKFont(12.f).lineHeight) / 2,
                                         stateLabelWidth,
                                         MKFont(12.f).lineHeight)];
    CGFloat nameWidth = self.contentView.frame.size.width - offset - rightIconWidth - 10.f - stateLabelWidth - 10.f;
    [self.deviceNameLabel setFrame:CGRectMake(offset,
                                              10.f,
                                              nameWidth,
                                              MKFont(15.f).lineHeight)];
    [self.macLabel setFrame:CGRectMake(offset,
                                       self.contentView.frame.size.height - 10.f - MKFont(12.f).lineHeight,
                                       nameWidth,
                                       MKFont(12.f).lineHeight)];
    [self.lineView setFrame:CGRectMake(15.f,
                                       self.contentView.frame.size.height - CUTTING_LINE_HEIGHT,
                                       self.contentView.frame.size.width - 2 * 15,
                                       CUTTING_LINE_HEIGHT)];
}

#pragma mark - event method
- (void)deleteButtonPressed {
    if ([self.delegate respondsToSelector:@selector(sp_cellDeleteButtonPressed:)]) {
        [self.delegate sp_cellDeleteButtonPressed:self.indexPath.row];
    }
}

- (void)contentPanelTapAction {
    if (self.contentPanel.frame.origin.x == 0) {
        if ([self.delegate respondsToSelector:@selector(sp_cellTapAction:)]) {
            [self.delegate sp_cellTapAction:self.indexPath.row];
        }
        return;
    }
    if (self.contentPanel.frame.origin.x < 0){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.contentPanel.frame;
            frame.origin.x += deleteButtonWidth;
            self.contentPanel.frame = frame;
            self.shouldSetFrame = NO;
        }];
        return;
    }
}

- (void)swipeEventBeTriggered:(UISwipeGestureRecognizer *)swipeGesture{
    if ([self.delegate respondsToSelector:@selector(sp_cellResetFrame)]) {
        [self.delegate sp_cellResetFrame];
    }
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft){
        if (self.contentPanel.frame.origin.x == 0) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.contentPanel.frame;
                frame.origin.x -= deleteButtonWidth;
                self.contentPanel.frame = frame;
                self.shouldSetFrame = YES;
            }];
        }
        return;
    }
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight){
        if (self.contentPanel.frame.origin.x < 0) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.contentPanel.frame;
                frame.origin.x += deleteButtonWidth;
                self.contentPanel.frame = frame;
                self.shouldSetFrame = NO;
            }];
        }
        return;
    }
}

#pragma mark - public method
- (void)resetCellFrame{
    if (self.shouldSetFrame && self.contentPanel.frame.origin.x < 0) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.contentPanel.frame;
            frame.origin.x += deleteButtonWidth;
            self.contentPanel.frame = frame;
            self.shouldSetFrame = NO;
        }];
    }
}

- (BOOL)canReset{
    return self.shouldSetFrame;
}

- (void)resetFlagForFrame{
    self.shouldSetFrame = NO;
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
- (void)addSwipeRecognizer{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] init];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeLeft addTarget:self action:@selector(swipeEventBeTriggered:)];
    [self.contentPanel addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] init];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeRight addTarget:self action:@selector(swipeEventBeTriggered:)];
    [self.contentPanel addGestureRecognizer:swipeRight];
}

#pragma mark - getter
- (UIView *)contentPanel {
    if (!_contentPanel) {
        _contentPanel = [[UIView alloc] init];
        _contentPanel.backgroundColor = COLOR_WHITE_MACROS;
        [_contentPanel addTapAction:self selector:@selector(contentPanelTapAction)];
    }
    return _contentPanel;
}

- (UIView *)deleteBackView {
    if (!_deleteBackView) {
        _deleteBackView = [[UIView alloc] init];
        _deleteBackView.backgroundColor = COLOR_WHITE_MACROS;
    }
    return _deleteBackView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleteButton setBackgroundColor:[UIColor redColor]];
        [_deleteButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:MKFont(13.f)];
        
        [_deleteButton addTarget:self
                          action:@selector(deleteButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UILabel *)deviceNameLabel {
    if (!_deviceNameLabel) {
        _deviceNameLabel = [[UILabel alloc] init];
        _deviceNameLabel.textColor = DEFAULT_TEXT_COLOR;
        _deviceNameLabel.textAlignment = NSTextAlignmentLeft;
        _deviceNameLabel.font = MKFont(15.f);
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

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = CUTTING_LINE_COLOR;
    }
    return _lineView;
}

@end
