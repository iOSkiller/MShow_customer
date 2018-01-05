//
//  YYCartBarView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYCartBarActionType) {
    YYCartBarActionTypeFollowGoods,
    YYCartBarActionTypeDisFollowGoods,
    YYCartBarActionTypeShowShop,
    YYCartBarActionTypeShowCart,
    YYCartBarActionTypeShowMyshow,
    YYCartBarActionTypePay,
};

@interface YYCartBarView : UIView
@property (nonatomic, copy) void (^buttonBlock)(YYCartBarActionType actionType);
@property (nonatomic, assign) NSInteger goodsCount;

@end
