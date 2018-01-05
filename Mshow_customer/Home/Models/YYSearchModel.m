//
//  YYSearchModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchModel.h"

@implementation YYSearchModel
- (void)setContent:(NSString *)content
{
    _content = content;
    _content_width = [content getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] size:CGSizeMake(MAXFLOAT, 44 - RELATIVE_WIDTH(20))].size.width + RELATIVE_WIDTH(20);
    CGFloat maxWidth = WIN_WIDTH - RELATIVE_WIDTH(52);
    if (_content_width > maxWidth) {
        _content_height = [content getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] size:CGSizeMake(maxWidth, MAXFLOAT)].size.height + RELATIVE_WIDTH(38);
    } else {
        _content_height = RELATIVE_WIDTH(70);
    }
}

+ (NSArray *)testHistoryArray
{
    YYSearchModel *model1 = [YYSearchModel new];
    model1.content = @"大衣";
    
    YYSearchModel *model2 = [YYSearchModel new];
    model2.content = @"短裤";
    
    YYSearchModel *model3 = [YYSearchModel new];
    model3.content = @"连衣裙";
    
    YYSearchModel *model4 = [YYSearchModel new];
    model4.content = @"半身裙";
    
    YYSearchModel *model5 = [YYSearchModel new];
    model5.content = @"加绒卫衣";
    
    YYSearchModel *model6 = [YYSearchModel new];
    model6.content = @"毛衣宽松";
    
    return @[model1, model2, model3, model4, model5, model6];
}

+ (NSArray *)testHotArray
{
    YYSearchModel *model1 = [YYSearchModel new];
    model1.content = @"大衣";
    
    YYSearchModel *model2 = [YYSearchModel new];
    model2.content = @"短裤";
    
    YYSearchModel *model3 = [YYSearchModel new];
    model3.content = @"连衣裙";
    
    YYSearchModel *model4 = [YYSearchModel new];
    model4.content = @"半身裙";
    
    YYSearchModel *model5 = [YYSearchModel new];
    model5.content = @"加绒卫衣";
    
    YYSearchModel *model6 = [YYSearchModel new];
    model6.content = @"毛衣宽松";
    
    return @[model1, model2, model3, model4, model5, model6];
}

@end
