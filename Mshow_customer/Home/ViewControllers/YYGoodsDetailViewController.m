//
//  YYGoodsDetailViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsDetailViewController.h"
#import "YYGoodsDetailView.h"
#import "YYGoodsModel.h"
#import "YYCommentModel.h"
#import "YYShoppingcartViewController.h"
#import "YYShoppingCartSpecificationView.h"
#import "YYSettleDealViewController.h"

#import "YYGoodsHandle.h"

@interface YYGoodsDetailViewController () <YYGoodsDetailViewDelegate, YYShoppingCartSpecificationViewDelegate>
@property (nonatomic, weak) YYGoodsDetailView *detailView;
@property (nonatomic, strong) YYGoodsModel *goodsModel;

@end

@implementation YYGoodsDetailViewController

- (YYGoodsDetailView *)detailView {
    if (!_detailView) {
        YYGoodsDetailView *view = [[YYGoodsDetailView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - iPhone_MARGIN_BOTTOM)];
        view.delegate = self;
        [self.view addSubview:view];
        _detailView = view;
    }
    return _detailView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self detailView];
    self.detailView.commentArray = [YYCommentModel testShowDataArray];
    [self setUpRightItem:@"" selectedTitle:@"" image:@"img_service" highImage:@"img_service" target:self  action:@selector(showService)];
    [self fetchData];
}

- (void)fetchData
{
    WS(ws);
    [YYGoodsHandle executeGoodsDetail:@"18" colorID:@"8" colorSizeID:@"25" success:^(id obj) {
        StrongSelf(strongSelf);
        strongSelf = ws;
        strongSelf.goodsModel = obj;
        strongSelf.detailView.goodsModel = _goodsModel;
    } failed:^(id failed) {
        StrongSelf(strongSelf);
        strongSelf = ws;
        [strongSelf showMessage:failed hud:nil duration:1.2];
    }];
}

- (void)showService
{
    
}

#pragma mark - YYGoodsDetailViewDelegate
- (void)executeShowMyShow
{
    YYShoppingCartSpecificationView *view = [[YYShoppingCartSpecificationView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT)];
    view.delegate = self;
    view.animationType = YYShoppingCartAnimationTypeBottom;
    view.isImmediatedBuy = NO;
    [view show];
}

- (void)executeShowShoppingCart
{
    [self.navigationController pushViewController:[YYShoppingcartViewController new] animated:YES];
}

- (void)executeShowShop:(NSString *)shop_id
{
    [self showShopDetail:shop_id];
}

- (void)executePay:(YYGoodsModel *)goodsModel
{
    YYShoppingCartSpecificationView *view = [[YYShoppingCartSpecificationView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT)];
    view.delegate = self;
    view.animationType = YYShoppingCartAnimationTypeBottom;
    view.isImmediatedBuy = YES;
    [view show];
    
}

- (void)executeFollowGoods:(YYGoodsModel *)goodsModel
{
    
}

- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)executeSelecSpec:(YYGoodsModel *)goodsModel
{
    YYShoppingCartSpecificationView *view = [[YYShoppingCartSpecificationView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT)];
    view.delegate = self;
    view.animationType = YYShoppingCartAnimationTypeBottom;
    view.isImmediatedBuy = NO;
    [view show];
}

#pragma mark - YYShoppingCartSpecificationViewDelegate
- (void)addGoodsToCart:(NSInteger)totalCount goodsModel:(YYGoodsModel *)goodsModel
{
    self.detailView.goodsCount += 1;
}

- (void)gotoMakeDeal:(YYGoodsModel *)goodsModel isImmediatedBuy:(BOOL)isImmediatedBuy
{
    YYSettleDealViewController *settleDealVC = [YYSettleDealViewController new];
    [self.navigationController pushViewController:settleDealVC animated:YES];
    
}

- (void)didSelectSpec:(YYGoodsModel *)goodsModel
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
