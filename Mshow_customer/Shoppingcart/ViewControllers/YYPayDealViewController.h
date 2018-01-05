//
//  YYPayDealViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

@class YYDealModel;

typedef NS_ENUM(NSInteger, YYPayDealViewControllerType) {
    YYPayDealViewControllerTypeBuy,
    YYPayDealViewControllerTypeSubscribe,
};

@interface YYPayDealViewController : YYBaseViewController
@property (nonatomic, assign) YYPayDealViewControllerType type;
@property (nonatomic, strong) YYDealModel *dealModel;

@end
