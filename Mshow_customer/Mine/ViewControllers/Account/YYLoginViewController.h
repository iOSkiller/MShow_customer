//
//  YYLoginViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

@class YYUserModel;

@interface YYLoginViewController : YYBaseViewController
@property (nonatomic, copy) void (^loginSuccessBlock)(YYUserModel *userModel);

@end
