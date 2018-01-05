//
//  YYDealHandle.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/25.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYDealHandle : YYBaseHandle
/**订单数据*/
+ (void)executeGetDeal:(YYDealStatusType)type userID:(NSString *)userID pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize success:(SuccessedBlock)success failed:(failed)failed;
/**修改订单状态*/
+ (void)executeChangeDealSatus:(YYDealStatusType)type orderID:(NSString *)orderID success:(SuccessedBlock)success failed:(failed)failed;
/**确认订单*/
+ (void)exuecuteSubmitDeal:(NSString *)orderShopId success:(SuccessedBlock)success failed:(failed)failed;
/**订单详情*/
+ (void)executeGetDealDetail:(NSString *)orderID success:(SuccessedBlock)success failed:(failed)failed;

@end
