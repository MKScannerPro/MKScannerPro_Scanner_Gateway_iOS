//
//  MKSPCAFileSelectController.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_sp_certListPageType) {
    mk_sp_caCertSelPage,
    mk_sp_clientKeySelPage,
    mk_sp_clientCertSelPage,
    mk_sp_clientP12CertPage,
};

@protocol MKSPCAFileSelectControllerDelegate <NSObject>

- (void)sp_certSelectedMethod:(mk_sp_certListPageType)certType certName:(NSString *)certName;

@end

@interface MKSPCAFileSelectController : MKBaseViewController

@property (nonatomic, weak)id <MKSPCAFileSelectControllerDelegate>delegate;

@property (nonatomic, assign)mk_sp_certListPageType pageType;

@end

NS_ASSUME_NONNULL_END
