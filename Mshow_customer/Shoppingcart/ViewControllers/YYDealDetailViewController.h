//
//  YYDealDetailViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

@class YYDealModel;

@interface YYDealDetailViewController : YYBaseViewController
@property (nonatomic, strong) YYDealModel *dealModel;
@property (nonatomic, copy) void (^deleteDealBlock)(YYDealModel *dealModel);
@property (nonatomic, copy) void (^recieveDealBlock)(YYDealModel *dealModel);

@end
