//
//  SZChooseCollectionView.h
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZChooseModel;
@class SZChooseFlowLayout;

NS_ASSUME_NONNULL_BEGIN

@interface SZChooseCollectionView : UIView

@property (nonatomic, strong) SZChooseModel *selectedModel;
@property (nonatomic, strong) SZChooseFlowLayout *flowLayout;

- (void)setDataWithArr:(NSMutableArray *)dataArr;
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
