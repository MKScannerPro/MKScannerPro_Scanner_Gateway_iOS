//
//  MKSPConnectionSettingController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/28.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPConnectionSettingController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKHudManager.h"
#import "MKTextField.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

@interface MKSPConnectionSettingController ()

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *noteLabel;

@property (nonatomic, strong)UILabel *msgNoteLabel;

@end

@implementation MKSPConnectionSettingController

- (void)dealloc {
    NSLog(@"MKSPConnectionSettingController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
}

#pragma mark - event method
- (void)confirmButtonPressed {
    if (!ValidStr(self.textField.text) || [self.textField.text integerValue] < 0 || [self.textField.text integerValue] > 1440) {
        [self.view showCentralToast:@"Params Error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [self.protocol sp_configConnectionTimeout:[self.textField.text integerValue]
                                     deviceID:[MKSPDeviceModeManager shared].deviceID
                                   macAddress:[MKSPDeviceModeManager shared].macAddress
                                        topic:[MKSPDeviceModeManager shared].subscribedTopic
                                     sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    }
                                  failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [self.protocol sp_readConnectionTimeoutWithDeviceID:[MKSPDeviceModeManager shared].deviceID
                                             macAddress:[MKSPDeviceModeManager shared].macAddress
                                                  topic:[MKSPDeviceModeManager shared].subscribedTopic
                                               sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        NSInteger value = [returnData[@"data"][@"timeout"] integerValue];
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)value];
    }
                                            failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Connection timeout option";
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.right.mas_equalTo(-30.f);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(30.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.view addSubview:self.noteLabel];
    CGSize size = [NSString sizeWithText:self.noteLabel.text
                                 andFont:self.noteLabel.font
                              andMaxSize:CGSizeMake(kViewWidth - 2 * 15.f, MAXFLOAT)];
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.textField.mas_bottom).mas_offset(15.f);
        make.height.mas_equalTo(size.height);
    }];
    [self.view addSubview:self.msgNoteLabel];
    CGSize msgNoteSize = [NSString sizeWithText:self.msgNoteLabel.text
                                        andFont:self.msgNoteLabel.font
                                     andMaxSize:CGSizeMake(kViewWidth - 2 * 15.f, MAXFLOAT)];
    [self.msgNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.noteLabel.mas_bottom).mas_offset(20.f);
        make.height.mas_equalTo(msgNoteSize.height);
    }];
    UIButton *confirmButton = [MKCustomUIAdopter customButtonWithTitle:@"Confirm"
                                                                target:self
                                                                action:@selector(confirmButtonPressed)];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.right.mas_equalTo(-30.f);
        make.top.mas_equalTo(self.msgNoteLabel.mas_bottom).mas_offset(60.f);
        make.height.mas_equalTo(40.f);
    }];
}

#pragma mark - getter
- (MKTextField *)textField {
    if (!_textField) {
        _textField = [[MKTextField alloc] initWithTextFieldType:mk_realNumberOnly];
        _textField.maxLength = 4;
        _textField.placeholder = @"0-1440";
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

- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = MKFont(14.f);
        _noteLabel.textColor = UIColorFromRGB(0xcccccc);
        _noteLabel.text = @"Range: 0-1440，unit: min";
        _noteLabel.numberOfLines = 0;
    }
    return _noteLabel;
}

- (UILabel *)msgNoteLabel {
    if (!_msgNoteLabel) {
        _msgNoteLabel = [[UILabel alloc] init];
        _msgNoteLabel.textAlignment = NSTextAlignmentCenter;
        _msgNoteLabel.font = MKFont(12.f);
        _msgNoteLabel.textColor = UIColorFromRGB(0xcccccc);
        _msgNoteLabel.text = @"If the connection time exceeds the configured value, device will restart automatically. Value 0 means no restart.";
        _msgNoteLabel.numberOfLines = 0;
    }
    return _msgNoteLabel;
}

@end
