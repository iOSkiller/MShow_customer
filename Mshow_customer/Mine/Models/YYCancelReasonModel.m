//
//  YYCancelReasonModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCancelReasonModel.h"

@implementation YYCancelReasonModel

- (void)setType:(YYCancelReasonType)type
{
    _type = type;
    switch (type) {
        case YYCancelReasonTypeOther:
            _content = @"其他原因";
            break;
        case YYCancelReasonTypeNotBuy:
            _content = @"我不想买了";
            break;
        case YYCancelReasonTypeOutOfStock:
            _content = @"卖家缺货";
            break;
        case YYCancelReasonTypeWorroyAddress:
            _content = @"地址信息填写错误";
            break;
        case YYCancelReasonTypeNone:
            break;
    }
}

+ (NSArray *)dataArray
{
    YYCancelReasonModel *model1 = [YYCancelReasonModel new];
    model1.type = YYCancelReasonTypeNotBuy;
    YYCancelReasonModel *model2 = [YYCancelReasonModel new];
    model2.type = YYCancelReasonTypeWorroyAddress;
    YYCancelReasonModel *model3 = [YYCancelReasonModel new];
    model3.type = YYCancelReasonTypeOutOfStock;
    YYCancelReasonModel *model4 = [YYCancelReasonModel new];
    model4.type = YYCancelReasonTypeOther;
    
    return @[model1, model2, model3, model4];
}

@end
