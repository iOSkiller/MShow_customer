//
//  YYGoodsSpecificationModel.m
//  DDFood
//
//  Created by YZ Y on 16/11/28.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYGoodsSpecificationModel.h"

@implementation YYGoodsSpecificationModel
- (void)setName:(NSString *)name
{
    _name = name;
//    _spec_width = [_name getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(34)] size:CGSizeMake(MAXFLOAT, 44 -  RELATIVE_WIDTH(20))].size.width + RELATIVE_WIDTH(20);
}

- (void)setPrice_info:(NSDictionary *)price_info
{
    if ([price_info isKindOfClass:[NSDictionary class]]) {
        _price_info = price_info;
        _price = [NSString stringWithFormat:@"%@", _price_info[@"price"]];
        _prom_type = [_price_info[@"prom_type"] integerValue];
        
        if ([_price_info[@"original_price"] isKindOfClass:[NSString class]]) {
            _original_price = _price_info[@"original_price"];
        }
        
        if ([_price_info[@"discounttime"] isKindOfClass:[NSString class]]) {
            _discounttime = _price_info[@"discounttime"];
        }
        
        if ([_price_info[@"begintime"] isKindOfClass:[NSString class]]) {
            _begintime = _price_info[@"begintime"];
        }
        
        if ([_price_info[@"nowtime"] isKindOfClass:[NSString class]]) {
            _nowtime = _price_info[@"nowtime"];
        }
    }
}

- (void)setType:(YYGoodsSpecificationType)type
{
    CGFloat width = [_name getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] size:CGSizeMake(MAXFLOAT, 44 - RELATIVE_WIDTH(20))].size.width + RELATIVE_WIDTH(20);
    CGFloat itemWidth = type == YYGoodsSpecificationTypeSpec ? RELATIVE_WIDTH(120) : RELATIVE_WIDTH(100);
    _spec_width = width > itemWidth ? width : itemWidth;
}

+ (NSArray *)testSpecDataArray
{
    YYGoodsSpecificationModel *model1 = [YYGoodsSpecificationModel new];
    model1.name = @"粉色";
    model1.specid = @"39";
    model1.enable = YES;
    model1.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model2 = [YYGoodsSpecificationModel new];
    model2.name = @"白色";
    model2.specid = @"40";
    model2.enable = YES;
    model2.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model3 = [YYGoodsSpecificationModel new];
    model3.name = @"黑色";
    model3.specid = @"41";
    model3.enable = YES;
    model3.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model4 = [YYGoodsSpecificationModel new];
    model4.name = @"绿色";
    model4.specid = @"42";
    model4.enable = NO;
    model4.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model5 = [YYGoodsSpecificationModel new];
    model5.name = @"黄色色";
    model5.specid = @"43";
    model5.enable = NO;
    model5.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model6 = [YYGoodsSpecificationModel new];
    model6.name = @"橙色";
    model6.specid = @"44";
    model6.enable = YES;
    model6.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model7 = [YYGoodsSpecificationModel new];
    model7.name = @"紫色";
    model7.specid = @"45";
    model7.enable = YES;
    model7.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model8 = [YYGoodsSpecificationModel new];
    model8.name = @"蓝色";
    model8.specid = @"46";
    model8.enable = YES;
    model8.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model9 = [YYGoodsSpecificationModel new];
    model9.name = @"天蓝色";
    model9.specid = @"47";
    model9.enable = YES;
    model9.type = YYGoodsSpecificationTypeSpec;
    
    return @[model1, model2, model3, model4, model5, model6, model7, model8, model9];
}

+ (NSArray *)testSizeDataArray
{
    YYGoodsSpecificationModel *model1 = [YYGoodsSpecificationModel new];
    model1.name = @"S";
    model1.specid = @"139";
    model1.enable = YES;
    model1.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model2 = [YYGoodsSpecificationModel new];
    model2.name = @"M";
    model2.specid = @"140";
    model2.enable = YES;
    model2.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model3 = [YYGoodsSpecificationModel new];
    model3.name = @"L";
    model3.specid = @"141";
    model3.enable = YES;
    model3.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model4 = [YYGoodsSpecificationModel new];
    model4.name = @"XL";
    model4.specid = @"142";
    model4.enable = NO;
    model4.type = YYGoodsSpecificationTypeSpec;
    
    YYGoodsSpecificationModel *model5 = [YYGoodsSpecificationModel new];
    model5.name = @"XXL";
    model5.specid = @"143";
    model5.enable = NO;
    model5.type = YYGoodsSpecificationTypeSpec;
    return @[model1, model2, model3, model4, model5];
}

@end
