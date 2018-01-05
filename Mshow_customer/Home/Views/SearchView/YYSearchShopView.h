//
//  YYSearchShopView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYShopModel;

@protocol YYSearchShopViewDelegate <NSObject>
- (void)executeDidSelectShop:(YYShopModel *)shopModel;

@end

@interface YYSearchShopView : UIView
@property (nonatomic, weak) id <YYSearchShopViewDelegate> delegate;

@end
