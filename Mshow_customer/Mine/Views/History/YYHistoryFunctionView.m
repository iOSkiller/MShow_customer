//
//  YYHistoryFunctionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryFunctionView.h"

@interface YYHistoryFunctionView ()
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UIView *line;

@end

@implementation YYHistoryFunctionView

- (UIView *)line {
    if (!_line) {
        UIView *view = [UIView new];
        view.backgroundColor = YYSeparatorColor;
        [self addSubview:view];
        _line = view;
    }
    return _line;
}

- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _button = button;
    }
    return _button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self button];
        [self line];
        _originalFrame = frame;
        self.mj_y = WIN_HEIGHT;
        self.backgroundColor = [UIColor whiteColor];
        WS(ws);
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(ws);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(60)));
        }];
    }
    return self;
}

- (void)show
{
    self.mj_y = _originalFrame.origin.y;
//    self.mj_y = WIN_HEIGHT;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.mj_y = _originalFrame.origin.y;
//    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mj_y = WIN_HEIGHT;
    }];
}

#pragma mark - button action
- (void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeDelete)]) {
        [_delegate executeDelete];
    }
}


@end
