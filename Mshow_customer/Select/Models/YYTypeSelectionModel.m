//
//  YYTypeSelectionModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYTypeSelectionModel.h"

@implementation YYTypeSelectionModel

- (void)setContent:(NSString *)content
{
    _content = content;
    _content_width = [content getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(32))].size.width;
}

+ (NSArray *)testCategoryDataArray
{
    YYTypeSelectionModel *model1 = [YYTypeSelectionModel new];
    model1.selectionID = @"262";
    model1.content = @"长裙";
    
    YYTypeSelectionModel *model2 = [YYTypeSelectionModel new];
    model2.selectionID = @"263";
    model2.content = @"小礼裙";
    
    YYTypeSelectionModel *model3 = [YYTypeSelectionModel new];
    model3.selectionID = @"264";
    model3.content = @"大衣";
    
    YYTypeSelectionModel *model4 = [YYTypeSelectionModel new];
    model4.selectionID = @"265";
    model4.content = @"长裤";
    
    YYTypeSelectionModel *model5 = [YYTypeSelectionModel new];
    model5.selectionID = @"266";
    model5.content = @"衬衣";
    
    YYTypeSelectionModel *model6 = [YYTypeSelectionModel new];
    model6.selectionID = @"267";
    model6.content = @"T恤";
    
    YYTypeSelectionModel *model7 = [YYTypeSelectionModel new];
    model7.selectionID = @"268";
    model7.content = @"短裙";
    
    YYTypeSelectionModel *model8 = [YYTypeSelectionModel new];
    model8.selectionID = @"269";
    model8.content = @"鱼尾裙";
    
    YYTypeSelectionModel *model9 = [YYTypeSelectionModel new];
    model9.selectionID = @"270";
    model9.content = @"吊带背心";
    
    YYTypeSelectionModel *model10 = [YYTypeSelectionModel new];
    model10.selectionID = @"271";
    model10.content = @"羽绒服";
    
    YYTypeSelectionModel *model11 = [YYTypeSelectionModel new];
    model11.selectionID = @"272";
    model11.content = @"风衣";
    
    YYTypeSelectionModel *model12 = [YYTypeSelectionModel new];
    model12.selectionID = @"273";
    model12.content = @"吊带裙";
    
    return @[model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12,];
}

+ (NSArray *)testTypeDataArray
{
    YYTypeSelectionModel *model1 = [YYTypeSelectionModel new];
    model1.selectionID = @"2621";
    model1.content = @"甜美";
    
    YYTypeSelectionModel *model2 = [YYTypeSelectionModel new];
    model2.selectionID = @"2631";
    model2.content = @"田园";
    
    YYTypeSelectionModel *model3 = [YYTypeSelectionModel new];
    model3.selectionID = @"2641";
    model3.content = @"运动";
    
    YYTypeSelectionModel *model4 = [YYTypeSelectionModel new];
    model4.selectionID = @"2651";
    model4.content = @"休闲";
    
    YYTypeSelectionModel *model5 = [YYTypeSelectionModel new];
    model5.selectionID = @"2661";
    model5.content = @"日韩";
    
    YYTypeSelectionModel *model6 = [YYTypeSelectionModel new];
    model6.selectionID = @"2671";
    model6.content = @"成熟";
    
    YYTypeSelectionModel *model7 = [YYTypeSelectionModel new];
    model7.selectionID = @"2681";
    model7.content = @"复古";
    
    YYTypeSelectionModel *model8 = [YYTypeSelectionModel new];
    model8.selectionID = @"2691";
    model8.content = @"文艺";
    
    YYTypeSelectionModel *model9 = [YYTypeSelectionModel new];
    model9.selectionID = @"2701";
    model9.content = @"欧美";
    
    YYTypeSelectionModel *model10 = [YYTypeSelectionModel new];
    model10.selectionID = @"2711";
    model10.content = @"清新";
    
    YYTypeSelectionModel *model11 = [YYTypeSelectionModel new];
    model11.selectionID = @"2721";
    model11.content = @"森女";
    
    YYTypeSelectionModel *model12 = [YYTypeSelectionModel new];
    model12.selectionID = @"2731";
    model12.content = @"二次元";
    
    return @[model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12,];
}

+ (NSArray *)testMoreDataArray
{
    YYTypeSelectionModel *model1 = [YYTypeSelectionModel new];
    model1.selectionID = @"2623";
    model1.content = @"不限季节";
    
    YYTypeSelectionModel *model2 = [YYTypeSelectionModel new];
    model2.selectionID = @"2633";
    model2.content = @"春秋季";
    
    YYTypeSelectionModel *model3 = [YYTypeSelectionModel new];
    model3.selectionID = @"2643";
    model3.content = @"夏季";
    
    YYTypeSelectionModel *model4 = [YYTypeSelectionModel new];
    model4.selectionID = @"2653";
    model4.content = @"冬季";
    
    YYTypeSelectionModel *model5 = [YYTypeSelectionModel new];
    model5.selectionID = @"2663";
    model5.content = @"全部单品";
    
    YYTypeSelectionModel *model6 = [YYTypeSelectionModel new];
    model6.selectionID = @"2673";
    model6.content = @"在架单品";
    
    return @[model1, model2, model3, model4, model5, model6,];
}

+ (NSArray *)testSizeDataArray
{
    YYTypeSelectionModel *model1 = [YYTypeSelectionModel new];
    model1.selectionID = @"2622";
    model1.content = @"XXS";
    
    YYTypeSelectionModel *model2 = [YYTypeSelectionModel new];
    model2.selectionID = @"2632";
    model2.content = @"XS";
    
    YYTypeSelectionModel *model3 = [YYTypeSelectionModel new];
    model3.selectionID = @"2641";
    model3.content = @"S";
    
    YYTypeSelectionModel *model4 = [YYTypeSelectionModel new];
    model4.selectionID = @"2651";
    model4.content = @"M";
    
    YYTypeSelectionModel *model5 = [YYTypeSelectionModel new];
    model5.selectionID = @"2662";
    model5.content = @"L";
    
    YYTypeSelectionModel *model6 = [YYTypeSelectionModel new];
    model6.selectionID = @"2671";
    model6.content = @"XL";
    
    YYTypeSelectionModel *model7 = [YYTypeSelectionModel new];
    model7.selectionID = @"2682";
    model7.content = @"XXL";
    
    YYTypeSelectionModel *model8 = [YYTypeSelectionModel new];
    model8.selectionID = @"2692";
    model8.content = @"XXL";
    
    return @[model1, model2, model3, model4, model5, model6, model7, model8,];
}



@end
