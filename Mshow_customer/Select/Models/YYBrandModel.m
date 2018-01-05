//
//  YYBrandModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBrandModel.h"

@implementation YYBrandModel

+ (NSArray *)testDataArray
{
    YYBrandModel *model1 = [YYBrandModel new];
    model1.brand = @"y23";
    model1.likeCount = @"123";
    
    YYBrandModel *model2 = [YYBrandModel new];
    model2.brand = @"多啦衣梦";
    model2.likeCount = @"13";
    
    YYBrandModel *model3 = [YYBrandModel new];
    model3.brand = @"女神派";
    model3.likeCount = @"50";
    
    YYBrandModel *model4 = [YYBrandModel new];
    model4.brand = @"y123";
    model4.likeCount = @"32";
    
    YYBrandModel *model5 = [YYBrandModel new];
    model5.brand = @"y1234";
    model5.likeCount = @"89";
    
    return @[model1, model2, model3, model4, model5];
}

@end
