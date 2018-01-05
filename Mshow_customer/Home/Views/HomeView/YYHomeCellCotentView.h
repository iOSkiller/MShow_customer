//
//  YYHomeCellCotentView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@interface YYHomeCellCotentView : UIView
@property (nonatomic, assign) YYHomeCellType type;
@property (nonatomic, copy) void (^selectItemBlock)(YYGoodsModel *goodsModel, NSInteger index);
@property (nonatomic, copy) void (^showMoreBlock)(YYHomeCellType type);
@property (nonatomic, copy) NSArray *goodsArray;

@end
