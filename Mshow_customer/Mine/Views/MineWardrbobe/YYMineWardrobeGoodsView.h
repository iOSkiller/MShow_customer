//
//  YYMineWardrobeGoodsView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@interface YYMineWardrobeGoodsView : UIView
@property (nonatomic, assign) YYMineWardrobeViewType type;
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) BOOL showCount;

@end
