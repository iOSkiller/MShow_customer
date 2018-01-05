//
//  YYSubscribeSuccessView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDealModel;

@interface YYSubscribeSuccessView : UIView
@property (nonatomic, copy) void (^backActionBlock)(void);
@property (nonatomic, copy) void (^dealActionBlock)(void);
@property (nonatomic, strong) YYDealModel *dealModel;
- (instancetype)initWithFrame:(CGRect)frame type:(YYSubscribeSuccessViewType)type;

@end
