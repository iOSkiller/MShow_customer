//
//  YYWithDrawInfoView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWithDrawInfoView.h"

@interface YYWithDrawInfoView () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UIView *line;

@end

@implementation YYWithDrawInfoView

- (UITextField *)textField {
    if (!_textField) {
        UITextField *field = [UITextField new];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(130), RELATIVE_WIDTH(36))];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"金额  ￥ ";
        field.leftView = label;
        field.leftViewMode= UITextFieldViewModeAlways;
        field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        field.textColor = YYTextColor;
        field.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        field.placeholder = @"请输入要提现的金额";
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        field.backgroundColor = [UIColor whiteColor];
        field.returnKeyType = UIReturnKeyDone;
        field.delegate = self;
        [self addSubview:field];
        _textField = field;
    }
    return _textField;
}

- (UIView *)line {
    if (!_line) {
        UIView *view = [UIView new];
        view.backgroundColor = YYSeparatorColor;
        [self addSubview:view];
        _line = view;
    }
    return _line;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.text = @"可提现余额￥300.00元";
        [self addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}

- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"全部提现" forState:UIControlStateNormal];
        [button setTitleColor:mRGBToColor(0x1296cd) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [self addSubview:button];
        _button = button;
    }
    return _button;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self textField];
        [self infoLabel];
        [self button];
        [self line];
        _maxCash = 300.0;
        WS(ws);
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws);
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(119));
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textField.mas_bottom);
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(10));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
        }];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.centerY.equalTo(self.infoLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(146), RELATIVE_WIDTH(36)));
        }];
    }
    return self;
}

- (void)buttonAction
{
    self.textField.text = [NSString stringWithFormat:@"%.2f", _maxCash];
}

- (void)hideKeyBoard
{
    if (_textField) {
        [self.textField resignFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([current doubleValue] > 300.00) {
        self.infoLabel.textColor = YYGlobalColor;
        self.infoLabel.text = @"提现金额超过可提现金额";
    } else {
        self.infoLabel.textColor = YYGrayTextColor;
        self.infoLabel.text = @"可提现余额￥300.00元";
    }
    if (_didEndEdite) {
        _didEndEdite(textField.text);
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.infoLabel.textColor = YYGrayTextColor;
    self.infoLabel.text = @"可提现余额￥300.00元";
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}

@end
