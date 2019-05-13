//
//  SZChooseFlowLayout.m
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import "SZChooseFlowLayout.h"

@interface SZChooseFlowLayout()

@property (nonatomic, strong) NSMutableArray *attributesArr;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat maxY;

@end

@implementation SZChooseFlowLayout

- (instancetype)initWithCellHeight:(CGFloat)cellHeight
                        edgeInsets:(UIEdgeInsets)insets
                              type:(SZChooseFlowLayoutType)type
{
    self = [super init];
    if (self) {
        [self initialize];
        
        self.top    = insets.top;
        self.left   = insets.left;
        self.bottom = insets.bottom;
        self.right  = insets.right;
        self.cellHeight = cellHeight;
        self.layoutType = type;
    }
    return self;
}

- (void)initialize
{
    // Require
    self.attributesArr = [[NSMutableArray alloc] init];
    self.widthArr      = [[NSMutableArray alloc] init];
    self.cellHeight    = 0.f;
    // Optional
    self.top    = 0.f;
    self.left   = 0.f;
    self.bottom = 0.f;
    self.right  = 0.f;
    self.maxY   = 0.f;
    self.part   = 5;    // 默认5等分
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 每次更新要清空数据重新计算
    [self.attributesArr removeAllObjects];
    
    NSInteger cellNum = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < cellNum; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArr addObject:attributes];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArr;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, _maxY);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGFloat originWidth = layoutAttributes.bounds.size.width;
    // +20是因为widthArr中的width是文字的长度，因此给两边留空
    CGFloat currentWidth= (_layoutType==SZChooseFlowLayoutTrends && indexPath.row < _widthArr.count) ? [_widthArr[indexPath.row] floatValue] + 20 : [self widthTranslateByOriginWidth:originWidth];
    CGRect currentFrame = CGRectZero;
    
    if (self.attributesArr.count > 0) {
        UICollectionViewLayoutAttributes *lastLayoutAttributes = [self.attributesArr lastObject];
        if ( CGRectGetMaxX(lastLayoutAttributes.frame) + _right + currentWidth >= self.collectionView.bounds.size.width) {
            currentFrame.origin.x = _left;
            currentFrame.origin.y = CGRectGetMaxY(lastLayoutAttributes.frame) + _top;
        }else {
            currentFrame.origin.x = CGRectGetMaxX(lastLayoutAttributes.frame) + _right;
            currentFrame.origin.y = lastLayoutAttributes.frame.origin.y;
        }
    }else {
        currentFrame.origin.x = _left;
        currentFrame.origin.y = _top;
    }
    
    currentFrame.size.width = currentWidth;
    currentFrame.size.height= _cellHeight;
    layoutAttributes.frame  = currentFrame;
    
    self.maxY = CGRectGetMaxY(layoutAttributes.frame) + _bottom;
    
    return layoutAttributes;
}

- (CGFloat)widthTranslateByOriginWidth:(CGFloat)originWidth
{
    if (_layoutType == SZChooseFlowLayoutPartAlignment) {
        // 等分不等宽
        CGFloat edgeMargin = (_left + _right)/2;
        // 原来的宽度是文字的宽度，对于cell需加上文字与边距
        CGFloat contentWidth = originWidth+edgeMargin*2;
        for (int i = _part; i > 1; i--) {
            if (contentWidth < [self getCellWidthByLineNum:i]) {
                // 如果等分的宽度足够显示title
                return [self getCellWidthByLineNum:i];
            }
        }
    }
    if (_layoutType == SZChooseFlowLayoutStatic) {
        // 等分等宽
        return [self getCellWidthByLineNum:_part];
    }
    return 0.f;
}

- (CGFloat)getCellWidthByLineNum:(NSInteger)lineNum
{
    CGFloat edgeMargin = (_left+_right)/2;
    if (_layoutType == SZChooseFlowLayoutPartAlignment) {
        // 非等分，实际长度
        CGFloat fifPart = (self.collectionView.bounds.size.width - edgeMargin*(_part+1))/_part;
        CGFloat cellWidth = (fifPart*(_part - lineNum + 1) + edgeMargin*(_part - lineNum));
        return cellWidth;
    }
    
    return (self.collectionView.bounds.size.width - edgeMargin*(lineNum+1))/lineNum;
}

#pragma mark - Setter
- (void)setWidthArr:(NSMutableArray<NSNumber *> *)widthArr
{
    _widthArr = widthArr;
}

@end
