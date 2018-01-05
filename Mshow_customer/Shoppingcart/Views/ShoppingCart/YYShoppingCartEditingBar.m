//
//  YYShoppingCartEditingBar.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShoppingCartEditingBar.h"

@interface YYShoppingCartEditingBar ()
@property (nonatomic, weak) UIButton *deletButton;
@property (nonatomic, weak) UILabel *line;

@end

@implementation YYShoppingCartEditingBar

- (UILabel *)line {
    if (!_line) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xf0f0f0);
        [self addSubview:label];
        _line = label;
    }
    return _line;
}

- (UIButton *)deletButton {
    if (!_deletButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        [button setTitleColor:YYGlobalColor forState:UIControlStateNormal];
        button.layer.borderWidth = RELATIVE_WIDTH(1);
        button.layer.borderColor = YYGlobalColor.CGColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(deletAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _deletButton = button;
    }
    return _deletButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self deletButton];
        [self line];
        self.backgroundColor = [UIColor whiteColor];
        
        WS(ws);
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(2));
        }];
        
        [self.deletButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(44)));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(44));
        }];
        
    }
    return self;
}

- (void)deletAction
{
    if (_deletBlock) {
        _deletBlock();
    }
}


@end
