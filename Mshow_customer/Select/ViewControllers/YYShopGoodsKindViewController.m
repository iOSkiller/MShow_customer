//
//  YYShopGoodsKindViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopGoodsKindViewController.h"
#import "YYShopGoodsKindView.h"
#import "YYGoodsKindDisplayViewController.h"
#import "YYShopGoodsKindModel.h"

@interface YYShopGoodsKindViewController () <YYShopGoodsKindViewDelegate>
@property (nonatomic, weak) YYShopGoodsKindView *kindView;

@end

@implementation YYShopGoodsKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部分类";
    YYShopGoodsKindView *kindView = [[YYShopGoodsKindView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    kindView.delegate = self;
    [self.view addSubview:kindView];
    _kindView = kindView;
}

#pragma mark - YYShopGoodsKindViewDelegate
- (void)executeShowAllGoods
{
    YYGoodsKindDisplayViewController *goodsDisplayVC = [YYGoodsKindDisplayViewController new];
    goodsDisplayVC.title = @"全部商品";
    [self.navigationController pushViewController:goodsDisplayVC animated:YES];
}

- (void)executeShowAllKind:(YYShopGoodsKindModel *)typeModel
{
    YYGoodsKindDisplayViewController *goodsDisplayVC = [YYGoodsKindDisplayViewController new];
    goodsDisplayVC.title = typeModel.type_content;
    [self.navigationController pushViewController:goodsDisplayVC animated:YES];
}

- (void)executeShowKind:(YYShopGoodsKindModel *)kindModel
{
    YYGoodsKindDisplayViewController *goodsDisplayVC = [YYGoodsKindDisplayViewController new];
    goodsDisplayVC.title = kindModel.kind_content;
    [self.navigationController pushViewController:goodsDisplayVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
