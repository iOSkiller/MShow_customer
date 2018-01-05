//
//  YYChangeInfoViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/5.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

@interface YYChangeInfoViewController : YYBaseViewController
@property (nonatomic, assign) YYMineInfoType type;
@property (nonatomic, copy) void (^didFinishChangeInfoBlock)(NSString *info);

@end
