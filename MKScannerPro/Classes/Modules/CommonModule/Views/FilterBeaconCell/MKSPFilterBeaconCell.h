//
//  MKSPFilterBeaconCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKSPFilterBeaconCellDelegate <NSObject>

- (void)mk_sp_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_sp_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKSPFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKSPFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKSPFilterBeaconCellDelegate>delegate;

+ (MKSPFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
