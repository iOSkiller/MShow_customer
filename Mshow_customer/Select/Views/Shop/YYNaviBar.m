//
//  YYNaviBar.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYNaviBar.h"

@implementation YYNaviBar

- (void)setRightItem:(UIButton *)rightButton
{
    [self addSubview:rightButton];
    WS(ws);
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(48));
        make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
        make.size.mas_equalTo(rightButton.mj_size);
        
    }];
}

- (void)setLeftItem:(UIButton *)leftButton
{
    [self addSubview:leftButton];
    WS(ws);
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(48));
        make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
        make.size.mas_equalTo(leftButton.mj_size);
    }];
}

@end
