//
//  YYDealModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealModel.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"

@implementation YYDealModel
+ (NSArray *)testBuyDataArrary
{
    NSArray *goods = [YYGoodsModel testWomanArray];
    NSArray *shops = [YYShopModel testDataArray];
    YYDealModel *model1 = [YYDealModel new];
    model1.dealID = @"123467890";
    model1.goodsArray = @[goods[0]];
    model1.shopModel = shops[0];
    model1.price = @"204.00";
    model1.delivery_fee = @"4.00";
    model1.statusType = YYDealStatusTypeBought;
    
    YYDealModel *model2 = [YYDealModel new];
    model2.dealID = @"123467891";
    model2.goodsArray = @[goods[5], goods[1]];
    model2.shopModel = shops[1];
    model2.price = @"804.00";
    model2.delivery_fee = @"4.00";
    model2.statusType = YYDealStatusTypeBought;
    
    YYDealModel *model3 = [YYDealModel new];
    model3.dealID = @"123467892";
    model3.goodsArray = @[goods[3], goods[2], goods[4]];
    model3.shopModel = shops[2];
    model3.price = @"904.00";
    model3.delivery_fee = @"4.00";
    model3.statusType = YYDealStatusTypeBought;
    
    return @[model1, model2, model3];
}

+ (NSArray *)testTryDataArray
{
    NSArray *goods = [YYGoodsModel testWomanArray];
    NSArray *shops = [YYShopModel testDataArray];
    YYDealModel *model1 = [YYDealModel new];
    model1.dealID = @"123467890";
    model1.goodsArray = @[goods[0]];
    model1.shopModel = shops[0];
    model1.price = @"30.00";
    model1.delivery_fee = @"4.00";
    model1.statusType = YYDealStatusTypeTried;
    model1.returnChangeStatus = @"仅退款 退款成功";
    
    YYDealModel *model2 = [YYDealModel new];
    model2.dealID = @"123467891";
    model2.goodsArray = @[goods[5], goods[1]];
    model2.shopModel = shops[1];
    model2.price = @"80.00";
    model2.delivery_fee = @"4.00";
    model2.statusType = YYDealStatusTypeTried;
    model2.returnChangeStatus = @"退款退货 退款退货成功";
    
    YYDealModel *model3 = [YYDealModel new];
    model3.dealID = @"123467892";
    model3.goodsArray = @[goods[3], goods[2], goods[4]];
    model3.shopModel = shops[2];
    model3.price = @"90.00";
    model3.delivery_fee = @"4.00";
    model3.statusType = YYDealStatusTypeTried;
    model3.returnChangeStatus = @"退款退货 退款退货成功";
    
    return @[model1, model2, model3];
}

+ (instancetype)testDeal
{
    YYDealModel *model = [self new];
    model.shopsArray = [YYShopModel testDataArray];
    return model;
}

+ (instancetype)testWashDeal
{
    YYDealModel *model = [self new];
    
    YYGoodsModel *model1 = [YYGoodsModel new];
    model1.name = @"春秋装";
    model1.currentPrice = @"30.00";
    model1.count = @"2";
    
    YYGoodsModel *model2 = [YYGoodsModel new];
    model2.name = @"冬装";
    model2.currentPrice = @"45.00";
    model2.count = @"1";
    
    YYGoodsModel *model3 = [YYGoodsModel new];
    model3.name = @"4件套";
    model3.currentPrice = @"60";
    model3.count = @"1";
    
    model.goodsArray = @[model1, model2, model3];
    return model;
}

@end
