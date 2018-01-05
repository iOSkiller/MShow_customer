//
//  YYSelectWashShopView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYShopModel;

@protocol YYSelectWashShopViewDelegate <NSObject>
- (void)executeDidSelectShop:(YYShopModel *)shopModel;
- (void)executeSearchWashShop;

@end

@interface YYSelectWashShopView : UIView
@property (nonatomic, weak) id <YYSelectWashShopViewDelegate> delegate;

@end
