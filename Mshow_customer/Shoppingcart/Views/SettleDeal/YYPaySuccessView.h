//
//  YYPaySuccessView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@protocol YYPaySuccessViewDelegate <NSObject>
- (void)executeShowGoodsModel:(YYGoodsModel *)goodsModel;
- (void)executeShowDeal;
- (void)executeBackHome;

@end

@interface YYPaySuccessView : UIView
@property (nonatomic, weak) id <YYPaySuccessViewDelegate> delegate;

@end
