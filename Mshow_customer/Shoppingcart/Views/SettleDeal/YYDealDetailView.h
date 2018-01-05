//
//  YYDealDetailView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYDealModel;
@class YYCouponModel;
@class YYGoodsModel;

@protocol YYDealDetailViewDelegate <NSObject>
/**物流详情*/
- (void)executeShowDealDeliveryDetail:(YYDealModel *)dealModel;
/**选择优惠券*/
- (void)executeSelectCoupon;
/**商品详情*/
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel;

@end


@interface YYDealDetailView : UIView
@property (nonatomic, strong) YYDealModel *dealModel;
@property (nonatomic, strong) YYCouponModel *couponModel;
@property (nonatomic, weak) id <YYDealDetailViewDelegate> delegate;

@end
