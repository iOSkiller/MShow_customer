//
//  YYHomeDateHandle.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/25.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeDateHandle.h"
#import "YYGoodsModel.h"

@implementation YYHomeDateHandle
#pragma mark - 首页轮播
+ (void)executeGetBanner:(SuccessedBlock)success failed:(failed)failed
{
    [YYHttpHandle GET:AppendString(BaseURL, homeBanner) params:nil success:^(id json) {
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode: %@ errorCode: %@", @(statusCode), @(errorCode));
        failed(@(statusCode));
    }];
}

+ (void)executeGetHotGoods:(NSString *)pageNum pageSize:(NSString *)pageSize success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"pageNum": pageNum,
                          @"pageSize": pageSize
                          };
    [YYHttpHandle GET:AppendString(BaseURL, weekyHotGoods) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"status"] boolValue]) {
            NSArray *array = [YYGoodsModel mj_objectArrayWithKeyValuesArray:dict[@"model"]];
            success(array);
        }
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode: %@ errorCode: %@", @(statusCode), @(errorCode));
        failed(@(statusCode));
    }];
}

+ (void)executeGetNewGoods:(NSString *)pageNum pageSize:(NSString *)pageSize success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"pageNum": pageNum,
                          @"pageSize": pageSize
                          };
    [YYHttpHandle GET:AppendString(BaseURL, weekyHotGoods) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"status"] boolValue]) {
            NSArray *array = [YYGoodsModel mj_objectArrayWithKeyValuesArray:dict[@"model"]];
            success(array);
        }
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode: %@ errorCode: %@", @(statusCode), @(errorCode));
        failed(@(statusCode));
    }];
}

@end
