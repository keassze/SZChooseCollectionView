//
//  SZChooseCollectionViewCell.h
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZChooseModel.h"


#define SCREEN_WIDTH_6            375.0
#define SCREEN_WIDTHRATE_6 ([UIScreen mainScreen].bounds.size.width / SCREEN_WIDTH_6)  // 以 6 为基准
#define kSZChooseCollectionCellLabelFont    [UIFont systemFontOfSize:12*SCREEN_WIDTHRATE_6]

NS_ASSUME_NONNULL_BEGIN

@interface SZChooseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SZChooseModel *chooseModel;

- (void)setCellWithModel:(SZChooseModel *)model;

@end

NS_ASSUME_NONNULL_END
