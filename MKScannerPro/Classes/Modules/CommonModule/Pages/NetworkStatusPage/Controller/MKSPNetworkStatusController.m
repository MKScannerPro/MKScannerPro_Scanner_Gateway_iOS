//
//  MKSPNetworkStatusController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPNetworkStatusController.h"

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

@interface MKSPNetworkStatusController ()

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *noteLabel;

@end

@implementation MKSPNetworkStatusController

- (void)dealloc {
    NSLog(@"MKSPNetworkStatusController销毁");
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
    if (!ValidStr(self.textField.text) || [self.textField.text integerValue] < 0 || ([self.textField.text integerValue] > 0 && [self.textField.text integerValue] < 10) || [self.textField.text integerValue] > 86400) {
        [self.view showCentralToast:@"Params Error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [self.protocol sp_configNetworkStatusReportingInterval:[self.textField.text integerValue]
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
    [self.protocol sp_readNetworkStatusReportingIntervalWithDeviceID:[MKSPDeviceModeManager shared].deviceID
                                                          macAddress:[MKSPDeviceModeManager shared].macAddress
                                                               topic:[MKSPDeviceModeManager shared].subscribedTopic
                                                            sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        NSInteger value = [returnData[@"data"][@"interval"] integerValue];
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)value];
    }
                                                         failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Network status report period";
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.right.mas_equalTo(-30.f);
        make.top.mas_equalTo(defaultTopInset + 30.f);
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
    UIButton *confirmButton = [MKCustomUIAdopter customButtonWithTitle:@"Confirm"
                                                                target:self
                                                                action:@selector(confirmButtonPressed)];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.right.mas_equalTo(-30.f);
        make.top.mas_equalTo(self.noteLabel.mas_bottom).mas_offset(60.f);
        make.height.mas_equalTo(40.f);
    }];
}

#pragma mark - getter
- (MKTextField *)textField {
    if (!_textField) {
        _textField = [[MKTextField alloc] initWithTextFieldType:mk_realNumberOnly];
        _textField.maxLength = 5;
        _textField.placeholder = @"10-86400";
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
        _noteLabel.font = MKFont(13.f);
        _noteLabel.textColor = UIColorFromRGB(0xcccccc);
        _noteLabel.text = @"Range: 0 or 10-86400, unit: s";
        _noteLabel.numberOfLines = 0;
    }
    return _noteLabel;
}

@end
