//
//  YYSelectShopViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYShopModel;
@class YYGoodsModel;

@interface YYSelectShopViewCell : UITableViewCell
/**按钮回调*/
@property (nonatomic, copy) void (^gotoShopBlock)(YYShopModel *model);
/**展示商品*/
@property (nonatomic, copy) void (^showGoodsBlock)(YYGoodsModel *model);
@property (nonatomic, strong) YYShopModel *shopModel;

@end
