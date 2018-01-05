//
//  YYShopModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopModel.h"
#import "YYGoodsModel.h"

@implementation YYShopModel
+ (NSArray *)testDataArray
{
    YYShopModel *model1 = [YYShopModel new];
    model1.goodsArray = [YYGoodsModel testDataArray];
    model1.shopName = @"y23";
    model1.isCouponed = NO;
    model1.goodsCount = @"123";
    model1.saleCount = @"40";
    model1.distance = @"10";
    model1.delivery_duration = @"30";
    
    YYShopModel *model2 = [YYShopModel new];
    model2.goodsArray = [YYGoodsModel testManArray];
    model2.shopName = @"多啦衣梦";
    model2.isCouponed = YES;
    model2.goodsCount = @"23";
    model2.saleCount = @"78";
    model2.distance = @"12";
    model2.delivery_duration = @"40";
    
    YYShopModel *model3 = [YYShopModel new];
    model3.goodsArray = [YYGoodsModel testWomanArray];
    model3.shopName = @"女神派";
    model3.isCouponed = YES;
    model3.goodsCount = @"233";
    model3.saleCount = @"60";
    model3.distance = @"14";
    model3.delivery_duration = @"50";
    
    return @[model1, model2, model3];
}


+ (NSArray *)testWashShopAarray
{
    YYShopModel *model1 = [YYShopModel new];
    model1.shopName = @"红星干洗店";
    model1.distance = @"10";
    model1.address = @"秦淮区龙蟠中路";
    model1.phone = @"18306118609";
    model1.delivery_duration = @"30";
    
    YYShopModel *model2 = [YYShopModel new];
    model2.shopName = @"衣到家";
    model2.distance = @"12";
    model2.address = @"鼓楼区建宁路";
    model2.phone = @"18061740419";
    model2.delivery_duration = @"40";
    
    YYShopModel *model3 = [YYShopModel new];
    model3.shopName = @"福奈特干洗店";
    model3.distance = @"14";
    model3.address = @"江宁区胜利路";
    model3.phone = @"17358880711";
    model3.delivery_duration = @"50";
    
    YYShopModel *model4 = [YYShopModel new];
    model4.shopName = @"桂平干洗店";
    model4.distance = @"15";
    model4.address = @"鼓楼区建宁路22号";
    model4.phone = @"17358880711";
    model4.delivery_duration = @"60";
    
    YYShopModel *model5 = [YYShopModel new];
    model5.shopName = @"铜山干洗店";
    model5.distance = @"18";
    model5.address = @"鼓楼区建宁路22号-26号亚都大厦";
    model5.phone = @"17358880711";
    model5.delivery_duration = @"70";
    
    return @[model1, model2, model3, model4, model5];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected) {
        _selectedCount = self.goodsArray.count;
    }
}

@end
