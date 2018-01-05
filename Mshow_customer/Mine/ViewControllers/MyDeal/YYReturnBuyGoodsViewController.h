//
//  YYReturnBuyGoodsViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"
@class YYDealModel;

@interface YYReturnBuyGoodsViewController : YYBaseViewController
@property (nonatomic, strong) YYDealModel *dealModel;
@property (nonatomic, assign) YYMineFunctionType type;

@end
