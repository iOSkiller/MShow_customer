//
//  YYCommentDealViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"
@class YYDealModel;

@interface YYCommentDealViewController : YYBaseViewController
@property (nonatomic, copy) void (^didFinishCommentBlock)(YYDealModel *dealModel);
@property (nonatomic, strong) YYDealModel *dealModel;

@end
