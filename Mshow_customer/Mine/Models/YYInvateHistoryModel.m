//
//  YYInvateHistoryModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYInvateHistoryModel.h"

@implementation YYInvateHistoryModel
+ (NSArray *)testDataArray
{
    YYInvateHistoryModel *model1 = [YYInvateHistoryModel new];
    model1.name = @"衣二三";
    model1.date = @"2017-11-18  12:30";
    
    YYInvateHistoryModel *model2 = [YYInvateHistoryModel new];
    model2.name = @"多啦衣梦";
    model2.date = @"2017-11-11  9:30";
    
    YYInvateHistoryModel *model3 = [YYInvateHistoryModel new];
    model3.name = @"女神派";
    model3.date = @"2017-10-10  16:30";
    
    return @[model1, model2, model3];
}
@end
