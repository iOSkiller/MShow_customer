//
//  YYShopGoodsKindView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYShopGoodsKindModel;

@protocol YYShopGoodsKindViewDelegate <NSObject>
- (void)executeShowAllKind:(YYShopGoodsKindModel *)typeModel;
- (void)executeShowKind:(YYShopGoodsKindModel *)kindModel;
- (void)executeShowAllGoods;

@end

@interface YYShopGoodsKindView : UIView
@property (nonatomic, weak) id <YYShopGoodsKindViewDelegate> delegate;

@end
