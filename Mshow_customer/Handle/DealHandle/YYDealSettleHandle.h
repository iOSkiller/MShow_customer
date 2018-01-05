//
//  YYDealSettleHandle.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYDealSettleHandle : YYBaseHandle

/**
 结算订单（去支付）

 @param goodsArray 商品信息数组
 @param success 成功回调
 @param failed 失败回调
 */
+ (void)executeSettleDeal:(NSArray *)goodsArray success:(SuccessedBlock)success failed:(failed)failed;

/**
 生成订单

 @param goodsArray 商品信息数组
 @param addressId 地址ID
 @param date 收货日期
 @param bonusScore 积分
 @param buyRemark 购买备注
 @param success 成功回调
 @param failed 失败回调
 */
+ (void)executeMakeDeal:(NSString *)goodsArray addressId:(NSString *)addressId date:(NSDate *)date bonusScore:(NSString *)bonusScore buyRemark:(NSString *)buyRemark success:(SuccessedBlock)success failed:(failed)failed;
@end
