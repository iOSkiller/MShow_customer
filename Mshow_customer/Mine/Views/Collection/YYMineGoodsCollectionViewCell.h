//
//  YYMineGoodsCollectionViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@interface YYMineGoodsCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) void (^deleteActionBlock)(YYGoodsModel *goodsModel);
@property (nonatomic, copy) void (^selectActionBlock)(YYGoodsModel *goodsModel, BOOL isSelected);
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) BOOL isEditing;
@end
