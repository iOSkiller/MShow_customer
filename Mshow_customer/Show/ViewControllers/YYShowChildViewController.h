//
//  YYShowChildViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

typedef NS_ENUM(NSInteger, YYShowChildViewType) {
    YYShowChildViewTypeHot,
    YYShowChildViewTypeFollow,
};

@interface YYShowChildViewController : YYBaseViewController
@property (nonatomic, assign) YYShowChildViewType type;

@end
