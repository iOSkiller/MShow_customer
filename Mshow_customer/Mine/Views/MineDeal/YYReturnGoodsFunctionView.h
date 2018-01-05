//
//  YYReturnGoodsFunctionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYReturnGoodsFunctionView : UIView
@property (nonatomic, copy) void (^selectAllBlock)(BOOL isSelected);
@property (nonatomic, copy) void (^sureActionBlock)(void);
@property (nonatomic, assign) BOOL haveSelectdGoods;
@property (nonatomic, assign) BOOL isAllSelected;

@end
