//
//  YYGoodsTableCellTypeView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@interface YYGoodsTableCellTypeView : UIView
@property (nonatomic, copy) void (^buttonActionBlock)(void);
@property (nonatomic, strong) YYGoodsModel *goodsModel;

@end
