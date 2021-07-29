//
//  MKSPMQTTSSLCertificateView.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPMQTTSSLCertificateViewModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *fileName;

@property (nonatomic, assign)NSInteger index;

@end

@protocol MKSPMQTTSSLCertificateViewDelegate <NSObject>

- (void)sp_fileSelectedButtonPressed:(NSInteger)index;

@end

@interface MKSPMQTTSSLCertificateView : UIView

@property (nonatomic, strong)MKSPMQTTSSLCertificateViewModel *dataModel;

@property (nonatomic, weak)id <MKSPMQTTSSLCertificateViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
