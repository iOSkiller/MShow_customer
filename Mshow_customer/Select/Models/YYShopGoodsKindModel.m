//
//  YYShopGoodsKindModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopGoodsKindModel.h"

@implementation YYShopGoodsKindModel
+ (NSArray *)testDataArray
{
    YYShopGoodsKindModel *coatModel = [YYShopGoodsKindModel new];
    coatModel.type_id = @"987";
    coatModel.type_content = @"外套";
    coatModel.kindArray = [YYShopGoodsKindModel testCoatArray];
    
    YYShopGoodsKindModel *jackteModel = [YYShopGoodsKindModel new];
    jackteModel.type_id = @"988";
    jackteModel.type_content = @"上衣";
    jackteModel.kindArray = [YYShopGoodsKindModel testJacketArray];
    
    YYShopGoodsKindModel *trousersModel = [YYShopGoodsKindModel new];
    trousersModel.type_id = @"989";
    trousersModel.type_content = @"裤子";
    trousersModel.kindArray = [YYShopGoodsKindModel testTrousersArray];
    
    YYShopGoodsKindModel *skirtModel = [YYShopGoodsKindModel new];
    skirtModel.type_id = @"990";
    skirtModel.type_content = @"裙子";
    skirtModel.kindArray = [YYShopGoodsKindModel testSkirtArray];
    
    return @[jackteModel, coatModel, trousersModel, skirtModel];
}

+ (NSArray *)testCoatArray
{
    YYShopGoodsKindModel *model1 = [YYShopGoodsKindModel new];
    model1.kind_content = @"皮衣";
    model1.kind_id = @"90";
    
    YYShopGoodsKindModel *model2 = [YYShopGoodsKindModel new];
    model2.kind_content = @"风衣";
    model2.kind_id = @"91";
    
    YYShopGoodsKindModel *model3 = [YYShopGoodsKindModel new];
    model3.kind_content = @"羽绒服";
    model3.kind_id = @"92";
    
    YYShopGoodsKindModel *model4 = [YYShopGoodsKindModel new];
    model4.kind_content = @"开衫";
    model4.kind_id = @"93";
    
    return @[model1, model2, model3, model4];
}

+ (NSArray *)testJacketArray
{
    YYShopGoodsKindModel *model1 = [YYShopGoodsKindModel new];
    model1.kind_content = @"卫衣";
    model1.kind_id = @"80";
    
    YYShopGoodsKindModel *model2 = [YYShopGoodsKindModel new];
    model2.kind_content = @"毛衣";
    model2.kind_id = @"81";
    
    YYShopGoodsKindModel *model3 = [YYShopGoodsKindModel new];
    model3.kind_content = @"背心";
    model3.kind_id = @"82";
    
    YYShopGoodsKindModel *model4 = [YYShopGoodsKindModel new];
    model4.kind_content = @"衬衫";
    model4.kind_id = @"83";
    
    return @[model1, model2, model3, model4];
}

- (void)setKindArray:(NSArray *)kindArray
{
    _kindArray = kindArray;
    _cellHeight = RELATIVE_WIDTH(20) + ((int)ceil(kindArray.count / 2.0) + 1) * (RELATIVE_WIDTH(10) + RELATIVE_WIDTH(100));
}

+ (NSArray *)testTrousersArray
{
    YYShopGoodsKindModel *model1 = [YYShopGoodsKindModel new];
    model1.kind_content = @"牛仔裤";
    model1.kind_id = @"70";
    
    YYShopGoodsKindModel *model2 = [YYShopGoodsKindModel new];
    model2.kind_content = @"休闲裤";
    model2.kind_id = @"71";
    
    YYShopGoodsKindModel *model3 = [YYShopGoodsKindModel new];
    model3.kind_content = @"短裤";
    model3.kind_id = @"72";
    
    YYShopGoodsKindModel *model4 = [YYShopGoodsKindModel new];
    model4.kind_content = @"打底裤";
    model4.kind_id = @"73";
    
    return @[model1, model2, model3];
}

+ (NSArray *)testSkirtArray
{
    YYShopGoodsKindModel *model1 = [YYShopGoodsKindModel new];
    model1.kind_content = @"连衣裙";
    model1.kind_id = @"60";
    
    YYShopGoodsKindModel *model2 = [YYShopGoodsKindModel new];
    model2.kind_content = @"半身裙";
    model2.kind_id = @"61";
    
    YYShopGoodsKindModel *model3 = [YYShopGoodsKindModel new];
    model3.kind_content = @"礼服裙";
    model3.kind_id = @"62";
    
    YYShopGoodsKindModel *model4 = [YYShopGoodsKindModel new];
    model4.kind_content = @"西装裙";
    model4.kind_id = @"63";
    
    return @[model1, model2];
}

@end
