//
//  MKSPMQTTSettingForDeviceCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPMQTTSettingForDeviceCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *rightMsg;

- (CGFloat)fetchCellHeight;

@end

@interface MKSPMQTTSettingForDeviceCell : MKBaseCell

@property (nonatomic, strong)MKSPMQTTSettingForDeviceCellModel *dataModel;

+ (MKSPMQTTSettingForDeviceCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
