//
//  YYMyCouponView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYCouponModel;

@protocol YYMyCouponViewDelegate <NSObject>
- (void)executeSelectCoupon:(YYCouponModel *)couponModel;

@end

@interface YYMyCouponView : UIView
@property (nonatomic, assign) YYCouponType viewType;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) id <YYMyCouponViewDelegate> delegate;

@end
