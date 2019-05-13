//
//  SZChooseCollectionView.m
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import "SZChooseCollectionView.h"
#import "SZChooseCollectionViewCell.h"
#import "SZChooseFlowLayout.h"

static const CGFloat kSZChooseCollectionCellHeight = 24.f;

@interface SZChooseCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *widthArray;

@end

@implementation SZChooseCollectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initConfig];
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.collectionView];
}

- (void)initConfig
{
    self.datas = [[NSMutableArray alloc] init];
}

- (void)setDataWithArr:(NSMutableArray *)dataArr
{
    self.datas = dataArr?:_datas;
    self.widthArray = [self widthArrayWithModelArray:_datas];
    [self.flowLayout setWidthArr:_widthArray];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZChooseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass ([SZChooseCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.row >= _datas.count) {
        return cell;
    }
    [cell setCellWithModel:_datas[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZChooseCollectionViewCell *cell = (SZChooseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    SZChooseModel *model = cell.chooseModel;
    // 如果没有选中的model，则直接赋值
    if (!_selectedModel) {
        model.isSelected = YES;
        _selectedModel = model;
        [cell setChooseModel:model];
        [collectionView reloadData];
        return;
    }
    // 如果有选中的model
    // 选中的model是当前model，不做操作
    if (model.chooseID == _selectedModel.chooseID) {
        return;
    }
    // 否则需要取消此前选中的
    _selectedModel.isSelected = NO;
    model.isSelected = YES;
    _selectedModel = model;
    [cell setCellWithModel:model];
    [collectionView reloadData];
}

#pragma mark - UICollectionViewFlowLayout Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionViewLayout == self.flowLayout) {
        return CGSizeMake([self.widthArray[indexPath.row] floatValue], kSZChooseCollectionCellHeight);
    }
    return CGSizeZero;
}

#pragma mark - Pravite Method
- (NSMutableArray *)widthArrayWithModelArray:(NSArray *)modelArr
{
    NSMutableArray *widthArr = [[NSMutableArray alloc] init];
    // 用于计算text长度，不会实际使用
    UILabel *label = [[UILabel alloc] init];
    for (int i = 0; i < modelArr.count; i++) {
        SZChooseModel *model = modelArr[i];
        label.text = model.title;
        label.font = kSZChooseCollectionCellLabelFont;
        CGFloat currentWidth = [label sizeThatFits:CGSizeMake(CGFLOAT_MAX, kSZChooseCollectionCellHeight)].width;
        [widthArr addObject:@(currentWidth)];
    }
    return widthArr;
}

#pragma mark - Setter
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.collectionView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
}

#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.04].CGColor;
        _collectionView.layer.shadowOffset = CGSizeMake(0,2);
        _collectionView.layer.shadowOpacity = 1;
        _collectionView.layer.shadowRadius = 7;
        _collectionView.delegate    = self;
        _collectionView.dataSource  = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[SZChooseCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SZChooseCollectionViewCell class])];
    }
    return _collectionView;
}

- (SZChooseFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[SZChooseFlowLayout alloc] initWithCellHeight:kSZChooseCollectionCellHeight edgeInsets:UIEdgeInsetsMake(10, 10, 0, 10) type:SZChooseFlowLayoutTrends];
    }
    return _flowLayout;
}

@end
