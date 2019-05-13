//
//  ViewController.m
//  SZChooseCollectionView
//
//  Created by 何松泽 on 2019/5/13.
//  Copyright © 2019 HSZ. All rights reserved.
//

#import "ViewController.h"
#import "SZChooseCollectionView/SZChooseModel.h"
#import "SZChooseCollectionView/SZChooseCollectionView.h"
#import "SZChooseCollectionView/SZChooseFlowLayout.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) SZChooseCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _datas = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 16; i++) {
        SZChooseModel *model = [SZChooseModel new];
        model.title = [NSString stringWithFormat:@"%d~%d",i*20 + 1,(i+1)*20];
        model.chooseID = i;
        [_datas addObject:model];
    }
    
    _collectionView = [[SZChooseCollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 300)];
    [self.view addSubview:_collectionView];
    [_collectionView setDataWithArr:_datas];
    [_collectionView reloadData];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"倒排" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor brownColor]];
    [btn addTarget:self action:@selector(reverse) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 500, 50, 50)];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"等分等距" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(samePart) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setFrame:CGRectMake(50, 500, 80, 50)];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"等分不等距" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn2 addTarget:self action:@selector(samePartWithoutSameWidth) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setFrame:CGRectMake(130, 500, 100, 50)];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"动态" forState:UIControlStateNormal];
    [btn3 setBackgroundColor:[UIColor blueColor]];
    [btn3 addTarget:self action:@selector(trend) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setFrame:CGRectMake(230, 500, 80, 50)];
    [self.view addSubview:btn3];
}

- (void)reverse
{
    _datas = [[NSMutableArray alloc] initWithArray:[[_datas reverseObjectEnumerator] allObjects]];
    [_collectionView setDataWithArr:_datas];
    [_collectionView reloadData];
}

- (void)samePart
{
    _collectionView.flowLayout.layoutType = SZChooseFlowLayoutStatic;
    _collectionView.flowLayout.part = 3;
    [_collectionView reloadData];
}

- (void)samePartWithoutSameWidth
{
    _collectionView.flowLayout.layoutType = SZChooseFlowLayoutPartAlignment;
    _collectionView.flowLayout.part = 5;
    [_collectionView reloadData];
}

- (void)trend
{
    _collectionView.flowLayout.layoutType = SZChooseFlowLayoutTrends;
    [_collectionView reloadData];
}


@end
