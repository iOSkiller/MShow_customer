//
//  YYRegisterViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

typedef NS_ENUM(NSInteger, YYRegisterViewControllerType) {
    YYRegisterViewControllerTypeRegister,
    YYRegisterViewControllerTypeResetCode,
};

@interface YYRegisterViewController : YYBaseViewController
@property (nonatomic, assign) YYRegisterViewControllerType type;
@property (nonatomic, copy) void (^resetCodeSuccessBlock)(void);
@property (nonatomic, copy) void (^registerSuccessBlock)(void);

@end
