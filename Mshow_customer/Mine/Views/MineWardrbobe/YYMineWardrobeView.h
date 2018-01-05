//
//  YYMineWardrobeView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYShopModel;
@class YYDealModel;

@protocol YYMineWardrobeViewDelegate <NSObject>
/**归还衣服*/
- (void)executeReturnGoods:(YYGoodsModel *)goodsModel;
/**展示衣服*/
- (void)executeShowGoodsQuality:(YYGoodsModel *)goodsModel;
/**评论*/
- (void)executeCommentGoods:(YYGoodsModel *)goodsModel;
/**购买衣服*/
- (void)executeBuyGoods:(YYGoodsModel *)goodsModel;
/**商品详情*/
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel;
/**店铺详情*/
- (void)executeShowShopDetail:(YYShopModel *)shopModel;
/**物流信息*/
- (void)executeShowDeliveryDetail:(YYDealModel *)dealModel;
/**退换货*/
- (void)executeChangeGoods:(YYGoodsModel *)goodsModel;

@end

@interface YYMineWardrobeView : UIView
@property (nonatomic, assign) YYMineWardrobeViewType type;
@property (nonatomic, weak) id <YYMineWardrobeViewDelegate> delegate;
@property (nonatomic, copy) NSArray *dataArray;

@end
