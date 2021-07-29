//
//  MKSPAboutPageCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MKSPAboutCellModel;
@interface MKSPAboutPageCell : MKBaseCell

@property (nonatomic, strong)MKSPAboutCellModel *dataModel;

+ (MKSPAboutPageCell *)initCellWithTableView:(UITableView *)table;

@end

NS_ASSUME_NONNULL_END
