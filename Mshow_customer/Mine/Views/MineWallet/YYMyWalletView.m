//
//  YYMyWalletView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyWalletView.h"
#import "YYButton.h"

@interface YYMyWalletView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *sumLabel;
@property (nonatomic, weak) UIButton *chargeButton;
@property (nonatomic, weak) UIButton *withdrawButton;
@property (nonatomic, weak) UIButton *helpButton;

@end

@implementation YYMyWalletView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"账户余额";
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)sumLabel {
    if (!_sumLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.attributedText = [NSString str1:@"￥" font1:[UIFont boldSystemFontOfSize:RELATIVE_WIDTH(34)] color1:YYTextColor str2:@"180.00" font2:[UIFont boldSystemFontOfSize:RELATIVE_WIDTH(58)] color2:YYTextColor];
        [self addSubview:label];
        _sumLabel = label;
    }
    return _sumLabel;
}

- (UIButton *)chargeButton {
    if (!_chargeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(38)];
        [button setTitle:@"充值" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chargeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _chargeButton = button;
    }
    return _chargeButton;
}

- (UIButton *)withdrawButton {
    if (!_withdrawButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(38)];
        [button setTitle:@"提现" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(withdrawAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _withdrawButton = button;
    }
    return _withdrawButton;
}

- (UIButton *)helpButton {
    if (!_helpButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [button setTitle:@"常见问题" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _helpButton = button;
    }
    return _helpButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self titleLabel];
        [self sumLabel];
        [self chargeAction];
        [self withdrawButton];
        [self helpButton];
        self.backgroundColor = [UIColor whiteColor];
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(140));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(38));
        }];
        
        [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(56));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(60));
        }];
        
        
        [self.chargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(500));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(82));
        }];
        
        [self.withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.chargeButton.mas_bottom).offset(RELATIVE_WIDTH(100));
            make.left.right.height.equalTo(self.chargeButton);
        }];
        
        [self.helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(50));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(140), RELATIVE_WIDTH(32)));
            make.centerX.equalTo(ws);
        }];
        
    }
    return self;
}



#pragma mark - control action
- (void)chargeAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeCharge)]) {
        [_delegate executeCharge];
    }
}

- (void)withdrawAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeWithDrawCash)]) {
        [_delegate executeWithDrawCash];
    }
}

- (void)helpAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowHelp)]) {
        [_delegate executeShowHelp];
    }
}


@end
