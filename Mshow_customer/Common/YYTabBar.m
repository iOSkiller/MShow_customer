//
//  YYTabBar.m
//  DDFood
//
//  Created by YZ Y on 16/6/2.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYTabBar.h"

@implementation YYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setOpaque:NO];
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [addButton sizeToFit];
        [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo([addButton backgroundImageForState:UIControlStateNormal].size);
            
        }];
    }
    return self;
}

- (void)addAction
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(clickActivityAction)]) {
        [_customDelegate clickActivityAction];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemWidth = self.frame.size.width/5;
    NSInteger itemIdnex = 0;
    
    for (UIView *subView in self.subviews) {
        if (![subView isKindOfClass:[UIControl class]] || [subView isKindOfClass:[UIButton class]]) {
            continue;
        }
        subView.mj_w = itemWidth;
        subView.mj_x = itemIdnex > 1 ? itemWidth * (itemIdnex + 1) : itemIdnex * itemWidth;
        itemIdnex ++;
    }
}


@end
