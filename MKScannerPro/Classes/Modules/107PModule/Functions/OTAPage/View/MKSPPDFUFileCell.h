//
//  MKSPPDFUFileCell.h
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSPPDFUFileCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *fileName;

@end

@protocol MKSPPDFUFileCellDelegate <NSObject>

- (void)spp_dfuFileButtonPressed:(NSInteger)index;

@end

@interface MKSPPDFUFileCell : MKBaseCell

@property (nonatomic, strong)MKSPPDFUFileCellModel *dataModel;

@property (nonatomic, weak)id <MKSPPDFUFileCellDelegate>delegate;

+ (MKSPPDFUFileCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
