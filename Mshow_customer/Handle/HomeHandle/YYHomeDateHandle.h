//
//  YYHomeDateHandle.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/25.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYHomeDateHandle : YYBaseHandle

/**首页轮播图*/
+ (void)executeGetBanner:(SuccessedBlock)success failed:(failed)failed;

/**每周爆品*/
+ (void)executeGetHotGoods:(NSString *)pageNum pageSize:(NSString *)pageSize success:(SuccessedBlock)success failed:(failed)failed;

/**每周新品*/
+ (void)executeGetNewGoods:(NSString *)pageNum pageSize:(NSString *)pageSize success:(SuccessedBlock)success failed:(failed)failed;
@end
