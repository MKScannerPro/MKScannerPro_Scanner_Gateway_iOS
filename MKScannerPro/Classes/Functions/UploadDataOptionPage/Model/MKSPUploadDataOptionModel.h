//
//  MKSPUploadDataOptionModel.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSPServerConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSPUploadDataOptionModel : NSObject<sp_uploadDataOptionProtocol>

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL deviceType;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL rawData;

@end

NS_ASSUME_NONNULL_END
