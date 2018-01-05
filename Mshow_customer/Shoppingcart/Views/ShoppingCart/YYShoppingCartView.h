//
//  YYShoppingCartView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYShopModel;

@protocol YYShoppingCartViewDelegate <NSObject>

- (void)shouldChangeShop:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath;
- (void)shouldChangeGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath;
- (void)executeShowCoupons:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath;
- (void)executeShowShopDetail:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath;
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath;
- (void)shouldRemoveGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath;

@end

@interface YYShoppingCartView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) id <YYShoppingCartViewDelegate> delegate;

- (void)reloadRow:(NSIndexPath *)indexPath;
- (void)reloadSection:(NSIndexPath *)indexPath;

@end
