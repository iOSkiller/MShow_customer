//
//  YYDamageSuspendView.m
//  Mshow_customer
//
//  Created by YYZ on 2018/1/3.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import "YYDamageSuspendView.h"
#import "YYArrowView.h"
#import "YYButton.h"

@interface YYDamageSuspendView ()
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) YYButton *detailButton;
@property (nonatomic, weak) UIButton *closeButton;
@property (nonatomic, weak) YYArrowView *arrowView;

@end

@implementation YYDamageSuspendView

- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blackColor];
        view.layer.cornerRadius = CommonCornerRadius;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        _contentView = view;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        label.text = @"折损说明";
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        label.text = @"袖口有轻微划痕";
        [self.contentView addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}

- (YYButton *)detailButton {
    if (!_detailButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setRightImage:[UIImage imageNamed:@"img_arrow_white_right"] selectedRightImage:nil leftTitle:@"查看详情" selectedLeftTitle:nil];
        button.normalColor = [UIColor whiteColor];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        button.imageSize = CGSizeMake(RELATIVE_WIDTH(10), RELATIVE_WIDTH(20));
        button.backgroundColor = [UIColor blackColor];
        [button addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _detailButton = button;
    }
    return _detailButton;
}


- (UIButton *)closeButton {
    if (!_closeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"ic_cancel"] forState:UIControlStateNormal];
        button.layer.cornerRadius = RELATIVE_WIDTH(20);
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor blackColor];
        [self addSubview:button];
        _closeButton = button;
    }
    return _closeButton;
}

- (YYArrowView *)arrowView {
    if (!_arrowView) {
        YYArrowView *view = [[YYArrowView alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(84), RELATIVE_WIDTH(102), RELATIVE_WIDTH(12), RELATIVE_WIDTH(8)) fillColor:[UIColor blackColor] direction:YYArrowViewDirectionDown];
        [self addSubview:view];
        _arrowView = view;
    }
    return _arrowView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws);
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.width.mas_equalTo(RELATIVE_WIDTH(180));
            make.height.mas_equalTo(RELATIVE_WIDTH(110));
        }];
        
        [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(ws);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(40));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(RELATIVE_WIDTH(10));
            make.centerX.equalTo(self.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(22));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(22));
        }];
        
        [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-RELATIVE_WIDTH(10));
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(RELATIVE_WIDTH(90));
            make.height.mas_equalTo(RELATIVE_WIDTH(22));
        }];
        
        [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(12), RELATIVE_WIDTH(8)));
        }];
        
    }
    return self;
}

- (void)closeAction
{
    if (_closeBlock) {
        _closeBlock();
    }
    [self removeFromSuperview];
}

- (void)tapAction
{
    if (_showDamageDetailBlock) {
        _showDamageDetailBlock();
    }
}

@end
