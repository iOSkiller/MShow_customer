//
//  YYShopHandle.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/25.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopHandle.h"

@implementation YYShopHandle
+ (void)executeGetShopInfo:(NSString *)shopId success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"shopId": shopId};
    [YYHttpHandle GET:AppendString(BaseURL, shopInfo) params:dic success:^(id json) {
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
    }];
}
@end
