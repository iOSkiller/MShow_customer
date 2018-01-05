//
//  YYReturnGoodsViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@interface YYReturnGoodsViewCell : UITableViewCell
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, copy) void (^selectBlock)(YYGoodsModel *goodsModel);

@end
