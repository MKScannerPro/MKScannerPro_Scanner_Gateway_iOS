//
//  MKSPPSystemTimeCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/3.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPSystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKSPPSystemTimeCellDelegate <NSObject>

- (void)spp_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKSPPSystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKSPPSystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKSPPSystemTimeCellDelegate>delegate;

+ (MKSPPSystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
