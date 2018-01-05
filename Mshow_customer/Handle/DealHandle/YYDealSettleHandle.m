//
//  YYDealSettleHandle.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealSettleHandle.h"
#import "YYHttpHandle.h"
#import "YYDealModel.h"
#import "NSDate+YYExtension.h"

@implementation YYDealSettleHandle
#pragma mark - 结算订单（去支付）
+ (void)executeSettleDeal:(NSArray *)goodsArray success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *goodsArrayDict = @{
                           @"1": @[
  @{@"colorSizeId": @"7", @"shareStatus": @"1"},
  @{@"colorSizeId": @"13", @"shareStatus": @"1"},
  @{@"colorSizeId": @"14", @"shareStatus": @"0"}],
                           };
//    NSDictionary *goodsArrayDict = @{ @"1": @[
//                                              @{@"colorSizeId": @"7", @"shareStatus": @"1"},
//                                              @{@"colorSizeId": @"13", @"shareStatus": @"1"},
//                                              @{@"colorSizeId": @"14", @"shareStatus": @"0"}],
//                                     @"2": @[
//                                             @{@"colorSizeId": @"24", @"shareStatus": @"1"},
//                                             @{@"colorSizeId": @"25", @"shareStatus": @"0"}]};
    NSString *jsonStr = [goodsArrayDict mj_JSONString];
    
    NSDictionary *dic = @{@"userId": @"2",
                          @"shopOrder" : jsonStr};
    [YYHttpHandle POST:AppendString(BaseURL, settleDeal) params:dic success:^(id json) {
        success(@"");
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
        failed(@(statusCode));
    }];
}

#pragma mark - 生成订单
+ (void)executeMakeDeal:(NSString *)goodsArray addressId:(NSString *)addressId date:(NSDate *)date bonusScore:(NSString *)bonusScore buyRemark:(NSString *)buyRemark success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"addressId": @"1", @"userId": @"2", @"shopOrder" : @"{\"1\":[{ \"colorSizeId\": \"7\",\"shareStatus\": \"1\"},{ \"colorSizeId\": \"13\", \"shareStatus\": \"1\"},{ \"colorSizeId\": \"14\", \"shareStatus\": \"0\"}],\"2\": [{\"colorSizeId\": \"24\",\"shareStatus\": \"1\" }, { \"colorSizeId\": \"25\", \"shareStatus\": \"0\" }]}", @"date": [NSString timestampFromDate:date], @"buyRemark": @"无", @"bonusScore": @"0"};
    [YYHttpHandle POST:AppendString(BaseURL, makeDeal) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"status"] boolValue]) {
            YYDealModel *dealModel = [YYDealModel mj_objectWithKeyValues:dict[@"model"]];
            success(dealModel);
        }
        
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
        failed(@(statusCode));
    }];
}

@end
