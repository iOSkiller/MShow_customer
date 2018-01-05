//
//  YYCollectionChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCollectionChildViewController.h"
//#import "YYMineGoodsCollectionView.h"
#import "YYMineCollectedGoodsTableView.h"
#import "YYMineShopCollectionView.h"
#import "YYMineBrandCollectionView.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"
#import "YYBrandModel.h"

@interface YYCollectionChildViewController () <YYMineCollectedGoodsTableViewDelegate, YYMineShopCollectionViewDelegate, YYMineBrandCollectionViewDelegate>
//@property (nonatomic, weak) YYMineGoodsCollectionView *goodsView;
@property (nonatomic, weak) YYMineCollectedGoodsTableView *goodsView;
@property (nonatomic, weak) YYMineShopCollectionView *shopView;
@property (nonatomic, weak) YYMineBrandCollectionView *brandView;
@end

@implementation YYCollectionChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    switch (_type) {
        case YYCollectionChildViewTypeShop:
            self.shopView.isEditing = isEditing;
            break;
        case YYCollectionChildViewTypeBrand:
            self.brandView.isEditing = isEditing;
            break;
        case YYCollectionChildViewTypeGoods:
            self.goodsView.isEditing = isEditing;
            break;
    }
}

- (void)setType:(YYCollectionChildViewType)type
{
    _type = type;
    switch (type) {
        case YYCollectionChildViewTypeShop:
        {
            YYMineShopCollectionView *shopView = [[YYMineShopCollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(80) - iPhone_ProtraitDisableViewHeight)];
            [self.view addSubview:shopView];
            _shopView = shopView;
            _shopView.dataArray = [YYShopModel testDataArray];
            break;
        }
        case YYCollectionChildViewTypeBrand:
        {
            YYMineBrandCollectionView *brandView = [[YYMineBrandCollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(80))];
            [self.view addSubview:brandView];
            _brandView = brandView;
            _brandView.dataArray = [YYBrandModel testDataArray];
            break;
        }
        case YYCollectionChildViewTypeGoods:
        {
//            YYMineGoodsCollectionView *goodsView = [[YYMineGoodsCollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(80) - iPhone_ProtraitDisableViewHeight)];
//            goodsView.delegate = self;
//            [self.view addSubview:goodsView];
//            _goodsView = goodsView;
//            _goodsView.dataArray = [YYGoodsModel testWomanArray];
            YYMineCollectedGoodsTableView *goodsView = [[YYMineCollectedGoodsTableView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(80) - iPhone_ProtraitDisableViewHeight)];
            goodsView.delegate = self;
            goodsView.dataArray = [YYGoodsModel testWomanArray];
            [self.view addSubview:goodsView];
            _goodsView = goodsView;
            break;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//#pragma mark - YYMineGoodsCollectionViewDelegate
//- (void)executeDeleteGoods:(YYGoodsModel *)goodsModel
//{
//    MJExtensionLog(@"delete liked goods %@", goodsModel);
//}
//
//- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
//{
//    MJExtensionLog(@"show liked goods detial %@", goodsModel);
//    [self showGoodsDetail:goodsModel.goodsID];
//}
//
//- (void)executeDeleteGoodsArray:(NSArray *)goodsArray
//{
//    MJExtensionLog(@"delete liked goods %@", goodsArray);
//}
#pragma mark - YYMineCollectedGoodsTableViewDelegate
- (void)tableViewDeleteGoods:(NSArray *)goodsArray
{
    [self.goodsView deleteSelectedGoods];
}

- (void)tableViewShowShopDetail:(NSString *)shopID
{
    [self showShopDetail:@""];
}

- (void)tableViewShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)tableViewShouldRemoveGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath
{
    [self.goodsView deleteGoods:goodsModel indexPath:indexPath];
}

#pragma mark - YYMineShopCollectionViewDelegate
- (void)executeGotoShop:(YYShopModel *)shopModel
{
    MJExtensionLog(@"go to liked shop %@", shopModel);
}

- (void)executeShowGoods:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"show liked shop's goods %@", goodsModel);
}

- (void)executeDeleteShops:(NSArray *)shopsArray
{
    MJExtensionLog(@"delete liked shops %@", shopsArray);
}

#pragma mark - YYMineBrandCollectionViewDelegate
- (void)executeShowBrandDetail:(YYBrandModel *)brandModel
{
    MJExtensionLog(@"show liked brand %@", brandModel);
}

- (void)executeDeleteLikeBrand:(YYBrandModel *)brandModel
{
    MJExtensionLog(@"delete liked brand %@", brandModel);
}

- (void)executeDeleteLikeBrands:(NSArray *)brandsArray
{
    MJExtensionLog(@"delete liked brands %@", brandsArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
