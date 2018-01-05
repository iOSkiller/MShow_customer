//
//  YYHomeContentViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@interface YYHomeContentViewCell : UICollectionViewCell
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) YYHomeCellType type;
- (void)setGoodsModel:(YYGoodsModel *)goodsModel type:(YYHomeCellType)type;

@end
