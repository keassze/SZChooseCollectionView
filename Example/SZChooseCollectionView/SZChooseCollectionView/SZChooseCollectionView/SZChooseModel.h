//
//  SZChooseModel.h
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZChooseModel : NSObject

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSInteger chooseID;
@property (nonatomic, strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
