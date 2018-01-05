//
//  YYChangeReturnModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChangeReturnModel.h"

@implementation YYChangeReturnModel
- (void)setChangeType:(YYChangeGoodsType)changeType
{
    _changeType = changeType;
    switch (changeType) {
        case YYChangeGoodsTypeNone:
            break;
        case YYChangeGoodsTypeReturnAll:
            _changeTypeContent = @"退款退货";
            break;
        case YYChangeGoodsTypeChangeGoods:
            _changeTypeContent = @"换货";
            break;
        case YYChangeGoodsTypeReturnMoney:
            _changeTypeContent = @"退款";
            break;
    }
}

- (void)setReasonType:(YYReturnChangeReasonType)reasonType
{
    _reasonType = reasonType;
    switch (reasonType) {
        case YYReturnChangeReasonTypeNone:
            break;
        case YYReturnChangeReasonTypeFake:
            _reasonTypeContent = @"假冒品牌";
            break;
        case YYReturnChangeReasonTypeNotLike:
            _reasonTypeContent = @"不喜欢";
            break;
        case YYReturnChangeReasonTypeLowQuality:
            _reasonTypeContent = @"质量问题";
            break;
        case YYReturnChangeReasonTypeGoodsDefect:
            _reasonTypeContent = @"收到商品少件/破损/污渍";
            break;
        case YYReturnChangeReasonTypeWorroyGoods:
            _reasonTypeContent = @"卖家发错货";
            break;
        case YYReturnChangeReasonTypeInconsistentWithDescription:
            _reasonTypeContent = @"与描述不符";
            break;
            
    }
}

+ (NSArray *)testTypeArray
{
    YYChangeReturnModel *model1 = [YYChangeReturnModel new];
    model1.changeType = YYChangeGoodsTypeReturnAll;
    
    YYChangeReturnModel *model2 = [YYChangeReturnModel new];
    model2.changeType = YYChangeGoodsTypeChangeGoods;
    
    YYChangeReturnModel *model3 = [YYChangeReturnModel new];
    model3.changeType = YYChangeGoodsTypeReturnMoney;
    
    return @[model1, model2, model3];
}

+ (NSArray *)testReasonArray
{
    YYChangeReturnModel *model1 = [YYChangeReturnModel new];
    model1.reasonType = YYReturnChangeReasonTypeInconsistentWithDescription;
    
    YYChangeReturnModel *model2 = [YYChangeReturnModel new];
    model2.reasonType = YYReturnChangeReasonTypeWorroyGoods;
    
    YYChangeReturnModel *model3 = [YYChangeReturnModel new];
    model3.reasonType = YYReturnChangeReasonTypeGoodsDefect;
    
    YYChangeReturnModel *model4 = [YYChangeReturnModel new];
    model4.reasonType = YYReturnChangeReasonTypeLowQuality;
    
    YYChangeReturnModel *model5 = [YYChangeReturnModel new];
    model5.reasonType = YYReturnChangeReasonTypeNotLike;
    
    YYChangeReturnModel *model6 = [YYChangeReturnModel new];
    model6.reasonType = YYReturnChangeReasonTypeFake;
    
    return @[model1, model2, model3, model4, model5, model6];
}

@end
