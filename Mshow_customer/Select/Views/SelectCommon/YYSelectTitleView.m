//
//  YYSelectTitleView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectTitleView.h"

@interface YYSelectTitleView ()

@end

@implementation YYSelectTitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(80))];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(24), RELATIVE_WIDTH(1), WIN_WIDTH - RELATIVE_WIDTH(48), RELATIVE_WIDTH(78))];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = mRGBToColor(0x646464);
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"热门品牌";
        [backView addSubview:label];
        _titleLabel = label;
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(1))];
        line1.backgroundColor = YYSeparatorColor;
        [backView addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(79), WIN_WIDTH, RELATIVE_WIDTH(1))];
        line2.backgroundColor = YYSeparatorColor;
        [backView addSubview:line2];
        
    }
    return self;
}

@end
