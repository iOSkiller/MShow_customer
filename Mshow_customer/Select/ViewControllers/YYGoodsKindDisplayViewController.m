//
//  YYGoodsKindDisplayViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsKindDisplayViewController.h"
#import "YYSelectGenderView.h"
#import "YYGoodsModel.h"
#import "YYGoodsDetailViewController.h"

@interface YYGoodsKindDisplayViewController () <YYSelectGenderViewDelegate>
@property (nonatomic, weak) YYSelectGenderView *goodsView;

@end

@implementation YYGoodsKindDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYSelectGenderView *goodsView = [[YYSelectGenderView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    goodsView.dataArray = [YYGoodsModel testWomanArray];
    goodsView.delegate = self;
    [self.view addSubview:goodsView];
    _goodsView = goodsView;
}

#pragma mark - YYSelectGenderViewDelegate
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)executeLikeGoods:(YYGoodsModel *)goodsModel isLike:(BOOL)isLike
{
    
}

- (void)collectionViewLoadMoreData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
