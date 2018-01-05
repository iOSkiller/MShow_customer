//
//  YYShoppingCartViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYShopModel;

@interface YYShoppingCartViewCell : UITableViewCell
@property (nonatomic, assign) BOOL isFirstCell;
@property (nonatomic, copy) void (^didChangeGoodsBlock)(YYGoodsModel *goodsModel);
@property (nonatomic, copy) void (^showCouponBlock)(YYShopModel *model);
@property (nonatomic, copy) void (^didChangeShopBlock)(YYShopModel *model);

@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, strong) YYShopModel *shopModel;


@end
