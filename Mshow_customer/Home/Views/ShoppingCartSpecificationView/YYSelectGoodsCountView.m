//
//  YYSelectGoodsCountView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectGoodsCountView.h"

@interface YYSelectGoodsCountView ()
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, weak) UIButton *minusButton;

@end

@implementation YYSelectGoodsCountView

{
    NSInteger _goodsCount;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"1";
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"购买数量";
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_add"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _addButton = button;
    }
    return _addButton;
}

- (UIButton *)minusButton {
    if (!_minusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_minus"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickMinusButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _minusButton = button;
    }
    return _minusButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self titleLabel];
        [self addButton];
        [self minusButton];
        [self countLabel];
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(60));
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(48), RELATIVE_WIDTH(32)));
            make.centerY.equalTo(ws);
            make.right.equalTo(self.addButton.mas_left).offset(-RELATIVE_WIDTH(2));
        }];
        
        [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.countLabel.mas_left).offset(-RELATIVE_WIDTH(2));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(60));
            make.centerY.equalTo(ws);
        }];
    }
    return self;
}

#pragma mark - buttonAction
- (void)clickAddButton
{
    self.minusButton.enabled = YES;
    if (_goodsCount < 99) {
        _goodsCount ++;
        self.countLabel.text = [NSString stringWithFormat:@"%@", @(_goodsCount)];
        if (_didSelectCountBlock) {
            _didSelectCountBlock(self.countLabel.text);
        }
    } else {
        self.addButton.enabled = NO;
    }
}

- (void)clickMinusButton
{
    self.addButton.enabled = YES;
    if (_goodsCount <= 1) {
        self.minusButton.enabled = NO;
    } else {
        _goodsCount --;
        self.countLabel.text = [NSString stringWithFormat:@"%@", @(_goodsCount)];
        if (_didSelectCountBlock) {
            _didSelectCountBlock(self.countLabel.text);
        }
    }
}

@end
