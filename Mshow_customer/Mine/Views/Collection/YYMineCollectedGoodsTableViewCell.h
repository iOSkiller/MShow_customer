//
//  YYMineCollectedGoodsTableViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@interface YYMineCollectedGoodsTableViewCell : UITableViewCell
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, copy) void (^showShopDetailBlock)(NSString *shopID);
@property (nonatomic, copy) void (^selectGoodsBlock)(YYGoodsModel *goodsModel);

@end
