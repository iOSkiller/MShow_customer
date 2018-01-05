//
//  YYMessageModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMessageModel.h"

@implementation YYMessageModel

+ (NSArray *)testDataArray
{
    YYMessageModel *model1 = [YYMessageModel new];
    model1.dealType = YYDealStatusTypeWaitForRecieve;
    model1.messageType = YYMessageTypeDelivery;
    model1.date = @"2017年9月18日 10:00";
    
    YYMessageModel *model2 = [YYMessageModel new];
    model2.messageType = YYMessageTypeNews;
    model2.date = @"2017年9月18日 9:00";
    
    return @[model1, model2];
}

@end
