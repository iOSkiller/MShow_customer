//
//  YYAddressModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYAddressModel.h"

@implementation YYAddressModel
+ (NSArray *)testDataArray
{
    YYAddressModel *model1 = [YYAddressModel new];
    model1.addressID = @"1";
    model1.province = @"江苏省";
    model1.city = @"南京市";
    model1.area = @"鼓楼区";
    model1.detailAddress = @"亚都大厦715室";
    model1.gender = @"女";
    model1.name = @"一二三";
    model1.phone = @"18306118609";
    model1.isDefault = YES;
    
    YYAddressModel *model2 = [YYAddressModel new];
    model2.addressID = @"2";
    model2.province = @"江苏省";
    model2.city = @"南京市";
    model2.area = @"江宁区";
    model2.detailAddress = @"紫金研创中心4栋1202";
    model2.gender = @"女";
    model2.name = @"多啦衣梦";
    model2.phone = @"18061740419";
    model2.isDefault = NO;
    
    YYAddressModel *model3 = [YYAddressModel new];
    model3.addressID = @"3";
    model3.province = @"江苏省";
    model3.city = @"南京市";
    model3.area = @"鼓楼区";
    model3.detailAddress = @"绿城花园1605";
    model3.gender = @"女";
    model3.name = @"女神派";
    model3.phone = @"13906110865";
    model3.isDefault = NO;
    
    YYAddressModel *model4 = [YYAddressModel new];
    model4.addressID = @"4";
    model4.province = @"江苏省";
    model4.city = @"南京市";
    model4.area = @"江宁区";
    model4.detailAddress = @"紫金研创中心4栋1202傅雷家书两地分居";
    model4.gender = @"女";
    model4.name = @"多啦衣梦";
    model4.phone = @"18061740419";
    model4.isDefault = NO;
    
    YYAddressModel *model5 = [YYAddressModel new];
    model5.addressID = @"5";
    model5.province = @"江苏省";
    model5.city = @"南京市";
    model5.area = @"鼓楼区";
    model5.detailAddress = @"绿城花园1605";
    model5.gender = @"女";
    model5.name = @"女神派";
    model5.phone = @"13906110865";
    model5.isDefault = NO;
    
    YYAddressModel *model6 = [YYAddressModel new];
    model6.addressID = @"6";
    model6.province = @"江苏省";
    model6.city = @"南京市";
    model6.area = @"鼓楼区";
    model6.detailAddress = @"绿城花园1605适得府君书了房间诶人";
    model6.gender = @"女";
    model6.name = @"女神派";
    model6.phone = @"13906110865";
    model6.isDefault = NO;
    
    return @[model1, model2, model3, model4, model5, model6];
}
@end
