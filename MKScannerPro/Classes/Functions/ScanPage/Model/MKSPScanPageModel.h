//
//  MKSPScanPageModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/14.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKSPScanPageModel : NSObject

@property (nonatomic, copy)NSString *deviceType;

@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, assign)NSInteger rssi;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *firmware;

@property (nonatomic, assign)BOOL connectable;

@end

NS_ASSUME_NONNULL_END
