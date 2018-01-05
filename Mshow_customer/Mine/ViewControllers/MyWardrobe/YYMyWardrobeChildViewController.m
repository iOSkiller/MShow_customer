//
//  YYMyWardrobeChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyWardrobeChildViewController.h"
#import "YYChangeReturnGoodsViewController.h"

#import "YYMineWardrobeView.h"
#import "YYShopModel.h"
#import "YYGoodsModel.h"
#import "YYDealModel.h"

@interface YYMyWardrobeChildViewController () <YYMineWardrobeViewDelegate>
@property (nonatomic, weak) YYMineWardrobeView *wardrobeView;

@end

@implementation YYMyWardrobeChildViewController

- (YYMineWardrobeView *)wardrobeView {
    if (!_wardrobeView) {
        YYMineWardrobeView *view = [[YYMineWardrobeView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(80))];
        view.delegate = self;
        [self.view addSubview:view];
        _wardrobeView = view;
    }
    return _wardrobeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wardrobeView];
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)setViewType:(YYMineWardrobeViewType)viewType
{
    _viewType = viewType;
    
}


- (void)fetchData
{
    self.wardrobeView.type = _viewType;
    self.wardrobeView.dataArray = _viewType == YYMineWardrobeViewTypeTried ? [YYDealModel testTryDataArray] : [YYDealModel testBuyDataArrary];
}

#pragma mark - YYMineWardrobeViewDelegate
- (void)executeShowGoodsQuality:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"show goods %@", goodsModel);
}

- (void)executeReturnGoods:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"return goods %@", goodsModel);
}

- (void)executeChangeGoods:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"change goods %@", goodsModel);
    [self.navigationController pushViewController:[YYChangeReturnGoodsViewController new] animated:YES];
}

- (void)executeBuyGoods:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"buy goods %@", goodsModel);
}

- (void)executeShowDeliveryDetail:(YYDealModel *)dealModel
{
    MJExtensionLog(@"delivery detail %@", dealModel);
}

- (void)executeShowShopDetail:(YYShopModel *)shopModel
{
    MJExtensionLog(@"show shop detail %@", shopModel);
}

- (void)executeCommentGoods:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"comment goods %@", goodsModel);
}

- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"show goods detail %@", goodsModel);
    [self showGoodsDetail:goodsModel.goodsID];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
