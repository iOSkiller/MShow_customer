//
//  YYCartBarView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCartBarView.h"
#import "YYButton.h"

#define bigButtonWidth RELATIVE_WIDTH(230)

@interface YYCartBarView ()
@property (nonatomic, weak) YYButton *shopButton;
@property (nonatomic, weak) YYButton *cartButton;
@property (nonatomic, weak) YYButton *followButton;
@property (nonatomic, weak) UIButton *showButton;
@property (nonatomic, weak) UIButton *payButton;
@property (nonatomic, weak) UILabel *countLabel;

@end

@implementation YYCartBarView

- (YYButton *)shopButton {
    if (!_shopButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setTopImage:[UIImage imageNamed:@"img_shop"] selectedTopImage:nil bottomTitle:@"店铺" selctedBottomTitle:nil];
        [button addTarget:self action:@selector(shopAction) forControlEvents:UIControlEventTouchUpInside];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        button.normalColor = YYGrayTextColor;
        [self addSubview:button];
        _shopButton = button;
    }
    return _shopButton;
}

- (YYButton *)cartButton {
    if (!_cartButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setTopImage:[UIImage imageNamed:@"tab_icon_wardrobe_n"] selectedTopImage:nil bottomTitle:@"衣橱" selctedBottomTitle:nil];
        [button addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        button.normalColor = YYGrayTextColor;
        [self addSubview:button];
        _cartButton = button;
    }
    return _cartButton;
}

- (YYButton *)followButton {
    if (!_followButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
         [button setTopImage:[UIImage imageNamed:@"img_follow_n"] selectedTopImage:[UIImage imageNamed:@"img_follow_pre"] bottomTitle:@"关注" selctedBottomTitle:@"已关注"];
        [button addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        button.normalColor = YYGrayTextColor;
        [self addSubview:button];
        _followButton = button;
    }
    return _followButton;
}


- (UIButton *)showButton {
    if (!_showButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"我来秀" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = mRGBToColor(0xfcb4b1);
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [button addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _showButton = button;
    }
    return _showButton;
}

- (UIButton *)payButton {
    if (!_payButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"立即购买" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = mRGBToColor(0xf3615f);
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [button addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _payButton = button;
    }
    return _payButton;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(18)];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = YYGlobalColor;
        label.layer.cornerRadius = RELATIVE_WIDTH(14);
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self shopButton];
        [self cartButton];
        [self showButton];
        [self payButton];
        [self countLabel];
        self.countLabel.text = @"33";
        self.backgroundColor = [UIColor whiteColor];
        
        WS(ws);
        CGFloat width = (WIN_WIDTH - bigButtonWidth * 2 - RELATIVE_WIDTH(20)) / 3;
        [self.shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(10));
            make.left.bottom.equalTo(ws);
            make.width.mas_equalTo(width);
        }];
        
        [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(10));
            make.bottom.equalTo(ws);
            make.left.equalTo(self.shopButton.mas_right);
            make.width.mas_equalTo(width);
        }];
        
        [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(10));
            make.bottom.equalTo(ws);
            make.left.equalTo(self.cartButton.mas_right);
            make.width.mas_equalTo(width);
        }];
        
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(ws);
            make.width.mas_equalTo(bigButtonWidth);
        }];
        
        [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(ws);
            make.right.equalTo(self.payButton.mas_left);
            make.width.mas_equalTo(bigButtonWidth);
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.centerY.equalTo(self.cartButton.imgView.mas_top);
            make.centerX.equalTo(self.cartButton.imgView.mas_right);
        }];
    }
    return self;
}

- (void)setGoodsCount:(NSInteger)goodsCount
{
    _goodsCount = goodsCount;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)goodsCount];
}

- (void)shopAction
{
    [self showAction:YYCartBarActionTypeShowShop];
}

- (void)cartAction
{
    [self showAction:YYCartBarActionTypeShowCart];
}

- (void)showAction
{
    [self showAction:YYCartBarActionTypeShowMyshow];
}

- (void)payAction
{
    [self showAction:YYCartBarActionTypePay];
}

- (void)showAction:(YYCartBarActionType)type
{
    if (_buttonBlock) {
        _buttonBlock(type);
    }
}

- (void)followAction:(UIButton *)sender
{
    self.followButton.selected = !self.followButton.isSelected;
    if (_buttonBlock) {
        _buttonBlock(self.followButton.isSelected ? YYCartBarActionTypeFollowGoods : YYCartBarActionTypeDisFollowGoods);
    }
}

@end
