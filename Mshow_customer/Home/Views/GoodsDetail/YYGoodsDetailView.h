//
//  YYGoodsDetailView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYShopModel;

@protocol YYGoodsDetailViewDelegate <NSObject>
/**立即购买*/
- (void)executePay:(YYGoodsModel *)goodsModel;
/**展示店铺*/
- (void)executeShowShop:(NSString *)shop_id;
/**展示购物车*/
- (void)executeShowShoppingCart;
/**展示我秀*/
- (void)executeShowMyShow;
/**关注商品*/
- (void)executeFollowGoods:(YYGoodsModel *)goodsModel;
/**展示商品详情*/
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel;
/**选择尺寸*/
- (void)executeSelecSpec:(YYGoodsModel *)goodsModel;

@end

@interface YYGoodsDetailView : UIView
@property (nonatomic, weak) id <YYGoodsDetailViewDelegate> delegate;
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, copy) NSArray *commentArray;
@property (nonatomic, assign) NSInteger goodsCount;
- (void)updateGoodsSpec:(YYGoodsModel *)goodsModel;

@end
