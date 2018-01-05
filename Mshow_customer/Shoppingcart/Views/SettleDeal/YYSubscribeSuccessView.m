//
//  YYSubscribeSuccessView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSubscribeSuccessView.h"
#import "YYDealModel.h"

@interface YYSubscribeSuccessView ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) UIButton *dealButton;
@property (nonatomic, weak) UIButton *backButton;

@end

@implementation YYSubscribeSuccessView

{
    YYSubscribeSuccessViewType _type;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_succeed"]];
        [self addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(46)];
        [self addSubview:label];
        _statusLabel = label;
    }
    return _statusLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(40)];
        [self addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}

- (UIButton *)dealButton {
    if (!_dealButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"查看订单" forState:UIControlStateNormal];
        [button setTitleColor:YYTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.borderColor = YYGrayTextColor.CGColor;
        button.layer.borderWidth = RELATIVE_WIDTH(1);
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(dealAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _dealButton = button;
    }
    return _dealButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回首页" forState:UIControlStateNormal];
        [button setTitleColor:YYTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.borderColor = YYGrayTextColor.CGColor;
        button.layer.borderWidth = RELATIVE_WIDTH(1);
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _backButton = button;
    }
    return _backButton;
}


- (instancetype)initWithFrame:(CGRect)frame type:(YYSubscribeSuccessViewType)type
{
    if (self = [super initWithFrame:frame]) {
        _type = type;
        self.backgroundColor = [UIColor whiteColor];
        switch (type) {
            case YYSubscribeSuccessViewTypeWash:
                self.statusLabel.text = @"待接单";
                break;
            case YYSubscribeSuccessViewTypeReturnGoods:
            {
                self.statusLabel.text = @"待接单";
            }
                break;
            case YYSubscribeSuccessViewTypeReturnGoodsBySelf:
                self.statusLabel.hidden = YES;
                break;
            case YYSubscribeSuccessViewTypeChangeReturnGoods:
                self.statusLabel.text = @"提交退换货申请成功";
                self.infoLabel.hidden = YES;
                break;
            default:
                break;
        }
        
        
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(100));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(24));
        }];
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws);
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(40));
            make.height.mas_equalTo(RELATIVE_WIDTH(48));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        if (!self.infoLabel.hidden) {
            self.infoLabel.text = [NSString stringWithFormat:@"预约时间%@", [NSString currentDate:@"yyyy-MM-dd HH:mm"]];
            [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(ws);
                make.top.equalTo(self.statusLabel.mas_bottom).offset(RELATIVE_WIDTH(28));
                make.height.mas_equalTo(RELATIVE_WIDTH(42));
                make.width.greaterThanOrEqualTo(@0);
            }];
        }
        CGFloat width = (WIN_WIDTH - RELATIVE_WIDTH(150) * 2 - RELATIVE_WIDTH(90)) / 2;
        [self.dealButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(150));
            make.height.mas_equalTo(RELATIVE_WIDTH(60));
            make.width.mas_equalTo(width);
        }];
        
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(150));
            make.height.mas_equalTo(RELATIVE_WIDTH(60));
            make.width.mas_equalTo(width);
        }];
    }
    return self;
}

- (void)backAction
{
    if (_backActionBlock) {
        _backActionBlock();
    }
}

- (void)dealAction
{
    if (_dealActionBlock) {
        _dealActionBlock();
    }
}

@end
