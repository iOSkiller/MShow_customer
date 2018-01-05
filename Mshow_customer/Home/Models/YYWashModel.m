//
//  YYWashModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWashModel.h"

@implementation YYWashModel

- (void)setInfo:(NSString *)info
{
    _info = info;
    CGFloat height = [info getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(24)] size:CGSizeMake(WIN_WIDTH - RELATIVE_WIDTH(52), MAXFLOAT)].size.height + RELATIVE_WIDTH(36);
    _cellHeight = RELATIVE_WIDTH(250) + height;
}

+ (NSArray *)testWashBedArray
{
    YYWashModel *model1 = [YYWashModel new];
    model1.name = @"床单/床罩";
    model1.description_content = @"尺寸200CM*220CM以下的常见棉质面料，棉麻面料";
    model1.info = @"真丝面料，奢侈品类不能清洗";
    model1.price = @"19";
    model1.image = @"wash01.png";
    
    YYWashModel *model2 = [YYWashModel new];
    model2.name = @"被罩";
    model2.description_content = @"尺寸200CM*220CM以下的常见棉质面料，棉麻面料";
    model2.info = @"真丝面料，奢侈品类不能清洗";
    model2.price = @"29";
    model2.image = @"wash06.png";
    
    YYWashModel *model3 = [YYWashModel new];
    model3.name = @"四件套";
    model3.description_content = @"床单一件，被罩一件，枕套2件，尺寸：200CM*220CM以下的常见棉质/棉麻";
    model3.info = @"真丝面料，奢侈品类不能清洗";
    model3.price = @"60";
    model3.image = @"wash02.png";
    
    YYWashModel *model4 = [YYWashModel new];
    model4.name = @"单人被";
    model4.description_content = @"单人被芯清洗，尺寸：150CM*200CM以下的常见棉花填充物被子";
    model4.info = @"羊毛，蚕丝被芯不能清洗";
    model4.price = @"19";
    model4.image = @"wash03.png";
    
    YYWashModel *model5 = [YYWashModel new];
    model5.name = @"双人被";
    model5.description_content = @"双人被芯清洗，尺寸：180CM*200CM以上的常见棉花填充物被子";
    model5.info = @"羊毛，蚕丝被芯不能清洗";
    model5.price = @"150";
    model5.image = @"wash04.jpg";
    
    YYWashModel *model6 = [YYWashModel new];
    model6.name = @"毛毯";
    model6.description_content = @"清洗范围：珊瑚绒毯，毛巾毯，拉舍尔毛毯，羊毛/羊绒毯，竹炭纤维毯";
    model6.info = @"奢侈品牌以及蚕丝毛毯不能清洗";
    model6.price = @"60";
    model6.image = @"wash05.png";
    
    return @[model1, model2, model3, model4, model5, model6];
}

+ (NSArray *)testWashCoatArray
{
    YYWashModel *model1 = [YYWashModel new];
    model1.name = @"夏装";
    model1.description_content = @"T恤，短袖，牛仔裤，内衣，衣服配件等夏季衣物";
    model1.info = @"非羊毛面料，不含绒的轻薄衣物，非真丝，且表面不含皮革";
    model1.price = @"15";
    model1.image = @"wash08.png";
    
    YYWashModel *model2 = [YYWashModel new];
    model2.name = @"春秋装";
    model2.description_content = @"西服，夹克，冲锋衣，风衣，毛衣等春秋衣物";
    model2.info = @"春秋普通衣物，非长款，非真丝，且表面不含皮革";
    model2.price = @"30";
    model2.image = @"wash07.png";
    
    YYWashModel *model3 = [YYWashModel new];
    model3.name = @"冬装";
    model3.description_content = @"毛呢大衣，羽绒服，棉衣，棉裤，等冬季衣物";
    model3.info = @"毛呢，羊毛，羽绒服，棉衣等厚重衣服，非真丝，且表面不含皮革";
    model3.price = @"45";
    model3.image = @"wash09.png";
    
    return @[model1, model2, model3];
}
@end
