//
//  YYPaySuccessViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYPaySuccessViewCell.h"

@interface YYPaySuccessViewCell ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *phoneLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UIButton *dealButton;
@property (nonatomic, weak) UIButton *backButton;

@end

@implementation YYPaySuccessViewCell

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"收货人：某某某";
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"18306118609";
        [self.contentView addSubview:label];
        _phoneLabel = label;
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.numberOfLines = 0;
        label.text = @"收货地址：江苏省-南京市-鼓楼区 亚都大厦715";
        [self.contentView addSubview:label];
        _addressLabel = label;
    }
    return _addressLabel;
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
        [self.contentView addSubview:button];
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
        [self.contentView addSubview:button];
        _backButton = button;
    }
    return _backButton;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)dealAction
{
    if (_dealActionBlock) {
        _dealActionBlock();
    }
}

- (void)backAction
{
    if (_backActionBlock) {
        _backActionBlock();
    }
}

- (void)setType:(YYPaySuccessViewCellType)type
{
    _type = type;
    switch (type) {
        case YYPaySuccessViewCellTypePrice:
            
            break;
        case YYPaySuccessViewCellTypeAddress:
        {
            [self nameLabel];
            [self phoneLabel];
            [self addressLabel];
            WS(ws);
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
                make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
                make.height.mas_equalTo(RELATIVE_WIDTH(32));
                make.width.greaterThanOrEqualTo(@30);
            }];
            
            [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
                make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
                make.height.mas_equalTo(RELATIVE_WIDTH(32));
                make.width.greaterThanOrEqualTo(@30);
            }];
            
            [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
                make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
                make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(32)));
                make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            }];
            
            break;
        }
        case YYPaySuccessViewCellTypeFuction:
        {
            [self dealButton];
            [self backButton];
            WS(ws);
            CGFloat width = (WIN_WIDTH - RELATIVE_WIDTH(150) * 2 - RELATIVE_WIDTH(90)) / 2;
            [self.dealButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(ws.contentView);
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(150));
                make.height.mas_equalTo(RELATIVE_WIDTH(60));
                make.width.mas_equalTo(width);
            }];
            
            [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(ws.contentView);
                make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(150));
                make.height.mas_equalTo(RELATIVE_WIDTH(60));
                make.width.mas_equalTo(width);
            }];
            break;
        }
        
    }
}

@end
