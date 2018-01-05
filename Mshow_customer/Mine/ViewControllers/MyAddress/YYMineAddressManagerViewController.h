//
//  YYMineAddressManagerViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"
@class YYAddressModel;

@interface YYMineAddressManagerViewController : YYBaseViewController
@property (nonatomic, copy) void (^didSelectAddressBlock)(YYAddressModel *addressModel);

@end
