//
//  YYMineShopCollectionViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYShopModel;
@class YYGoodsModel;

@interface YYMineShopCollectionViewCell : UITableViewCell
/**按钮回调*/
@property (nonatomic, copy) void (^gotoShopBlock)(YYShopModel *model);
/**展示商品*/
@property (nonatomic, copy) void (^showGoodsBlock)(YYGoodsModel *model);
/**选择回调*/
@property (nonatomic, copy) void (^selectShopBlock)(YYShopModel *shopModel ,BOOL isSelected);
@property (nonatomic, strong) YYShopModel *shopModel;
@property (nonatomic, assign) BOOL isEditing;

@end
