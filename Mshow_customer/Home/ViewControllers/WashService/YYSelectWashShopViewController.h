//
//  YYSelectWashShopViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"
@class YYShopModel;

@interface YYSelectWashShopViewController : YYBaseViewController
@property (nonatomic, copy) void (^didSelectWashShopBlock)(YYShopModel *shopModel);

@end
