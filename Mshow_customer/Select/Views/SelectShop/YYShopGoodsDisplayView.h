//
//  YYShopGoodsDisplayView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@interface YYShopGoodsDisplayView : UIView
@property (nonatomic, copy) void (^tapActionBlock)(YYGoodsModel *model);
@property (nonatomic, copy) NSArray *goodsArray;

@end
