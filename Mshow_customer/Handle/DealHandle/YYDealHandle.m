//
//  YYDealHandle.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/25.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealHandle.h"

@implementation YYDealHandle
#pragma mark - 获取订单列表
+ (void)executeGetDeal:(YYDealStatusType)type userID:(NSString *)userID pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"type": @"100",
                          @"userId": @"2",
                          @"pageNum": pageNum,
                          @"pageSize": pageSize,
                          };
    [YYHttpHandle GET:AppendString(BaseURL, getDeal) params:dic success:^(id json) {
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
    }];
}

#pragma mark - 修改订单状态
+ (void)executeChangeDealSatus:(YYDealStatusType)type orderID:(NSString *)orderID success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"orderId": @"10",
                          @"type": @"2",
                          };
    [YYHttpHandle POST:AppendString(BaseURL, changeDeal) params:dic success:^(id json) {
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
    }];
}

#pragma mark - 确认订单
+ (void)exuecuteSubmitDeal:(NSString *)orderShopId success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"orderShopId": orderShopId};
    [YYHttpHandle POST:AppendString(BaseURL, submitDeal) params:dic success:^(id json) {
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
    }];
}

#pragma mark - 订单详情
+ (void)executeGetDealDetail:(NSString *)orderID success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"orderShopId": orderID};
    [YYHttpHandle GET:AppendString(BaseURL, dealDeatil) params:dic success:^(id json) {
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
    }];
}

@end
