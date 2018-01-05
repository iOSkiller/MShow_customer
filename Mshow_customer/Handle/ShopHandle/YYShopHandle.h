//
//  YYShopHandle.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/25.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYShopHandle : YYBaseHandle
/**店铺首页*/
+ (void)executeGetShopInfo:(NSString *)shopId success:(SuccessedBlock)success failed:(failed)failed;

@end
