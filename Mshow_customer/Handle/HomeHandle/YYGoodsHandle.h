//
//  YYGoodsHandle.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYGoodsHandle : YYBaseHandle
/**商品详情*/
+ (void)executeGoodsDetail:(NSString *)goodsID colorID:(NSString *)colorID colorSizeID:(NSString *)colorSizeID success:(SuccessedBlock)successBlock failed:(failed)failed;
@end
