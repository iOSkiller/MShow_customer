//
//  YYSubscribeReturnGoodsView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDealModel;

@protocol YYSubscribeReturnGoodsViewDelegate <NSObject>
- (void)executeSureAction:(YYDealModel *)dealModel;

@end

@interface YYSubscribeReturnGoodsView : UIView
@property (nonatomic, weak) id <YYSubscribeReturnGoodsViewDelegate> delegate;
@property (nonatomic, assign) YYMineFunctionType type;

@end
