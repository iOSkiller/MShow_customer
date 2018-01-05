//
//  YYAppealViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

@class YYDealModel;

@interface YYAppealViewController : YYBaseViewController
@property (nonatomic, copy) void (^didFinishAppealBlock)(void);
@property (nonatomic, strong) YYDealModel *dealModel;

@end
