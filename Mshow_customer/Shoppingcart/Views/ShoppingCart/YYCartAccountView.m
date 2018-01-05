//
//  YYCartAccountView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCartAccountView.h"

@interface YYCartAccountView ()
@property (nonatomic, weak) UILabel *totalPriceLabel;
@property (nonatomic, weak) UIButton *selectAllButton;
@property (nonatomic, weak) UIButton *payButton;
@property (nonatomic, weak) UIView *line;

@end

@implementation YYCartAccountView

- (UIView *)line {
    if (!_line) {
        UIView *line = [UIView new];
        line.backgroundColor = YYSeparatorColor;
        [self addSubview:line];
        _line = line;
    }
    return _line;
}


- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _totalPriceLabel = label;
    }
    return _totalPriceLabel;
}

- (UIButton *)selectAllButton {
    if (!_selectAllButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"全选" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [button addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -RELATIVE_WIDTH(30), 0, 0);
        [self addSubview:button];
        _selectAllButton = button;
    }
    return _selectAllButton;
}

- (UIButton *)payButton {
    if (!_payButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = YYGlobalColor;
        [button addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"结算" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:YYDisableColor forState:UIControlStateDisabled];
        [self addSubview:button];
        _payButton = button;
    }
    return _payButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self selectAllButton];
        [self payButton];
        [self totalPrice];
        [self line];
        self.backgroundColor = [UIColor whiteColor];
        
        WS(ws);
        
        [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.centerY.equalTo(ws);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(140), RELATIVE_WIDTH(44)));
        }];
        
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(ws);
            make.width.mas_equalTo(RELATIVE_WIDTH(200));
        }];
        
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.payButton.mas_left).offset(-RELATIVE_WIDTH(10));
            make.centerY.equalTo(ws);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(280), RELATIVE_WIDTH(44)));
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(ws);
            make.right.equalTo(self.payButton.mas_left);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
    }
    return self;
}

- (void)setTotalPrice:(NSString *)totalPrice
{
    _totalPrice = totalPrice;
    self.totalPriceLabel.attributedText = [NSString str1:@"合计:" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:[NSString stringWithFormat:@"￥%@", totalPrice] font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    self.payButton.enabled = !_isEditing;
}

- (void)setIsShowSelected:(BOOL)isShowSelected
{
    _isShowSelected = isShowSelected;
    if (!_isShowSelected) {
        self.selectAllButton.hidden = YES;
        [self.selectAllButton removeFromSuperview];
    }
}

- (void)selectAllAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_delegate && [_delegate respondsToSelector:@selector(executeAllSelected:)]) {
        [_delegate executeAllSelected:sender.isSelected];
    }
}

- (void)setButtonTitle:(NSString *)title
{
    if ([title isValid]) {
        [self.payButton setTitle:title forState:UIControlStateNormal];
    }
    
}

- (void)payAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executePay)]) {
        [_delegate executePay];
    }
}


@end
