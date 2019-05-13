//
//  SZChooseCollectionViewCell.m
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import "SZChooseCollectionViewCell.h"

@interface SZChooseCollectionViewCell()

@property (nonatomic, strong) UILabel *chooseLabel;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *leftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightConstraint;

@end

@implementation SZChooseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:242/255.0 blue:247/255.0 alpha:1.0];
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds= YES;
    }
    return self;
}

- (void)setCellWithModel:(SZChooseModel *)model
{
    self.chooseModel = model;
    self.chooseLabel.text = model.title;
    self.chooseLabel.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    self.backgroundColor = model.isSelected ? [UIColor colorWithRed:97/255.0 green:156/255.0 blue:255/255.0 alpha:1.0]:[UIColor colorWithRed:241/255.0 green:242/255.0 blue:247/255.0 alpha:1.0];
}

- (UILabel *)chooseLabel
{
    if (!_chooseLabel) {
        _chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _chooseLabel.font = kSZChooseCollectionCellLabelFont;
        _chooseLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _chooseLabel.textAlignment = NSTextAlignmentCenter;
        _chooseLabel.numberOfLines = 0;
        _chooseLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_chooseLabel];
        // 工程如果有别的自动布局可以删除以下代码，改用别的自动布局
        _topConstraint = [NSLayoutConstraint constraintWithItem:_chooseLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
        _leftConstraint = [NSLayoutConstraint constraintWithItem:_chooseLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
        _rightConstraint = [NSLayoutConstraint constraintWithItem:_chooseLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
        _bottomConstraint = [NSLayoutConstraint constraintWithItem:_chooseLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
        [self.contentView addConstraints:@[_topConstraint,_leftConstraint,_bottomConstraint,_rightConstraint]];

    }
    return _chooseLabel;
}

@end
