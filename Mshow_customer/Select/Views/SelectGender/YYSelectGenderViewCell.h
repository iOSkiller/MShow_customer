//
//  YYSelectGenderViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@interface YYSelectGenderViewCell : UICollectionViewCell
@property (nonatomic, copy) void (^selectBlock)(YYGoodsModel *model, BOOL isSelected);
@property (nonatomic, strong) YYGoodsModel *goodsModel;

@end
