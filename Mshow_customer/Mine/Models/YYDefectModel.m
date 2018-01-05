//
//  YYDefectModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDefectModel.h"

@implementation YYDefectModel
+ (NSArray *)testDataAarray
{
    YYDefectModel *model1 = [YYDefectModel new];
    model1.content = @"单品有磨损";
    model1.defectID = @"1";
    
    YYDefectModel *model2 = [YYDefectModel new];
    model2.content = @"单品配件不全";
    model2.defectID = @"2";
    
    YYDefectModel *model3 = [YYDefectModel new];
    model3.content = @"单品有些旧";
    model3.defectID = @"3";
    
    YYDefectModel *model4 = [YYDefectModel new];
    model4.content = @"单品褶皱严重";
    model4.defectID = @"4";
    
    YYDefectModel *model5 = [YYDefectModel new];
    model5.content = @"单品不干净";
    model5.defectID = @"5";
    
    YYDefectModel *model6 = [YYDefectModel new];
    model6.content = @"单品差色大";
    model6.defectID = @"6";
    
    return @[model1, model2, model3, model4, model5, model6];
}

@end
