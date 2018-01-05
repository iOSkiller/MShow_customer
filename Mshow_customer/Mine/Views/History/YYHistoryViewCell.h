//
//  YYHistoryViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@interface YYHistoryViewCell : UICollectionViewCell
@property (nonatomic, copy) void (^likeActionBlock)(YYGoodsModel *goodsModel, BOOL isSelected);
@property (nonatomic, copy) void (^selectActionBlock)(YYGoodsModel *goodsModel, BOOL isSelected);
@property (nonatomic, copy) void (^deletActionBlock)(YYGoodsModel *goodsModel);
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) BOOL isEditing;

@end
