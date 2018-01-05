//
//  YYShopDetailView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYGoodsModel.h"

@protocol YYShopDetailViewDelegate <NSObject>
- (void)executeFollowGoods:(YYGoodsModel *)goodsModel;
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel;
- (void)executeShowAllKinds;
- (void)executeDidScroll:(CGFloat)contentY;

@end

@interface YYShopDetailView : UIView
@property (nonatomic, weak) id <YYShopDetailViewDelegate> delegate;

@end
