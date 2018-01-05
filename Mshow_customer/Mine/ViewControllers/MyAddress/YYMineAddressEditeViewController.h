//
//  YYMineAddressEditeViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

@class YYAddressModel;

typedef NS_ENUM(NSInteger, YYMineAddressEditeViewType) {
    YYMineAddressEditeViewTypeAdd,
    YYMineAddressEditeViewTypeEdite,
};

@interface YYMineAddressEditeViewController : YYBaseViewController
@property (nonatomic, assign) YYMineAddressEditeViewType type;
@property (nonatomic, strong) YYAddressModel *addressModel;

@end
