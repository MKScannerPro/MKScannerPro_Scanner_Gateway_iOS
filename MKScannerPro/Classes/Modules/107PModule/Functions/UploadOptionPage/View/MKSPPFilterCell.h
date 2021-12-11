//
//  MKSPPFilterCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/11/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPFilterCellModel : NSObject

/// cell标识符
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray <NSString *>*dataList;

@end

@protocol MKSPPFilterCellDelegate <NSObject>

- (void)spp_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index;

@end

@interface MKSPPFilterCell : MKBaseCell

@property (nonatomic, strong)MKSPPFilterCellModel *dataModel;

@property (nonatomic, weak)id <MKSPPFilterCellDelegate>delegate;

+ (MKSPPFilterCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
