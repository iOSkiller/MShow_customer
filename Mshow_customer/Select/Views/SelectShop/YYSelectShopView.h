//
//  YYSelectShopView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYShopModel;

@protocol YYSelectShopViewDelegate <NSObject>
/**展示商品*/
- (void)executeShowGoods:(YYGoodsModel *)goodsModel;
/**进入店铺*/
- (void)executeGotoShop:(YYShopModel *)shopModel;

@end

@interface YYSelectShopView : UIView
@property (nonatomic, weak) id <YYSelectShopViewDelegate> delegate;
@property (nonatomic, copy) NSArray *dataArray;

@end
