//
//  YYChargeSumModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChargeSumModel.h"

@implementation YYChargeSumModel
+ (NSArray *)testDataArray
{
    YYChargeSumModel *model1 = [YYChargeSumModel new];
    model1.content = @"充20送10";
    model1.sum = @"20";
    
    YYChargeSumModel *model2 = [YYChargeSumModel new];
    model2.content = @"充50送30";
    model2.sum = @"50";
    
    YYChargeSumModel *model3 = [YYChargeSumModel new];
    model3.content = @"充100送50";
    model3.sum = @"100";
    
    YYChargeSumModel *model4 = [YYChargeSumModel new];
    model4.content = @"充500送300";
    model4.sum = @"500";
    
    return @[model1, model2, model3, model4];
}
@end
