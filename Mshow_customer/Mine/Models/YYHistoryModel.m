//
//  YYHistoryModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryModel.h"
#import "YYGoodsModel.h"

@implementation YYHistoryModel
+ (NSArray *)testDataArray
{
    YYHistoryModel *model1 = [YYHistoryModel new];
    model1.goodsArray = [YYGoodsModel testManArray];
    model1.date = @"今天";
    model1.historyID = @"1";
    
    YYHistoryModel *model2 = [YYHistoryModel new];
    model2.goodsArray = [YYGoodsModel testWomanArray];
    model2.date = @"2017-11-10";
    model2.historyID = @"2";
    
    YYHistoryModel *model3 = [YYHistoryModel new];
    model3.goodsArray = [YYGoodsModel testChildArray];
    model3.date = @"2017-11-20";
    model3.historyID = @"3";
    
    return @[model1, model2, model3];
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}


@end
