//
//  MKSPBaseViewController.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPBaseViewController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKSPDeviceModeManager.h"
#import "MKSPDeviceModel.h"

@interface MKSPBaseViewController ()

@end

@implementation MKSPBaseViewController

- (void)dealloc {
    NSLog(@"MKSPBaseViewController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotifications];
}

#pragma mark - note
- (void)deviceOffline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"deviceID"])) {
        return;
    }
    [self processOfflineWithDeviceID:user[@"deviceID"]];
}

#pragma mark - Private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOffline:)
                                                 name:MKSPDeviceModelOfflineNotification
                                               object:nil];
}

- (void)processOfflineWithDeviceID:(NSString *)deviceID {
    if (![deviceID isEqualToString:[MKSPDeviceModeManager shared].deviceID] || ![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_sp_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    [self.view showCentralToast:@"device is off-line"];
    [self performSelector:@selector(gobackToListView) withObject:nil afterDelay:1.f];
}

- (void)gobackToListView {
    [self popToViewControllerWithClassName:@"MKSPDeviceListController"];
}

@end
