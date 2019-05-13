//
//  SZChooseFlowLayout.h
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SZChooseFlowLayoutType) {
    SZChooseFlowLayoutStatic =   0, // 等分等宽的布局
    SZChooseFlowLayoutPartAlignment,// 等分但是不等宽的布局
    SZChooseFlowLayoutTrends,       // 不等分动态宽度的布局
};

NS_ASSUME_NONNULL_BEGIN

@interface SZChooseFlowLayout : UICollectionViewFlowLayout

/** 每个cell的固定高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 布局类型 */
@property (nonatomic, assign) SZChooseFlowLayoutType layoutType;
/** 每行等分cell的数量（Only SZChooseFlowLayoutStatic | SZChooseFlowLayoutPartAlignment） */
@property (nonatomic, assign) int part;
/** 宽度集合（Only SZChooseFlowLayoutTrends Need） */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *widthArr;

/**
 建议使用初始化方法

 @param cellHeight 每个cell的固定高度
 @param insets 每个cell的insets
 @param type 布局类型
 */
- (instancetype)initWithCellHeight:(CGFloat)cellHeight
                        edgeInsets:(UIEdgeInsets)insets
                              type:(SZChooseFlowLayoutType)type;

@end

NS_ASSUME_NONNULL_END
