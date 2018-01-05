//
//  YYGoodsHandle.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsHandle.h"
#import "YYGoodsModel.h"

@implementation YYGoodsHandle
/**商品详情*/
+ (void)executeGoodsDetail:(NSString *)goodsID colorID:(NSString *)colorID colorSizeID:(NSString *)colorSizeID success:(SuccessedBlock)successBlock failed:(failed)failed
{
    NSDictionary *dic = @{@"goodsId": goodsID,
                          @"colorId": colorID,
                          @"colorSizeId": colorSizeID};
    
    [YYHttpHandle GET:AppendString(BaseURL, goodsDetail) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"status"] boolValue]) {
            YYGoodsModel *model = [YYGoodsModel mj_objectWithKeyValues:dict[@"model"]];
            successBlock(model);
        }
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%@ errorCode:%@", @(statusCode), @(errorCode));
    }];
}

@end
