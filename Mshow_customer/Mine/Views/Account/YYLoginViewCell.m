//
//  YYLoginViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYLoginViewCell.h"

@interface YYLoginViewCell () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *phoneField;
@property (nonatomic, weak) UITextField *codeField;
@property (nonatomic, weak) UITextField *passWordField;
@property (nonatomic, weak) UIButton *sendButton;
@property (nonatomic, weak) UIButton *seeButton;

@end

@implementation YYLoginViewCell

- (UITextField *)phoneField {
    if (!_phoneField) {
        UITextField *textField = [UITextField new];
        textField.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textField.textColor = YYTextColor;
        textField.placeholder = @"请输入手机号";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(130), RELATIVE_WIDTH(40))];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.text = @"手机号";
        textField.leftView = label;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.returnKeyType = UIReturnKeyNext;
        textField.delegate = self;
        [self.contentView addSubview:textField];
        _phoneField = textField;
    }
    return _phoneField;
}

- (UITextField *)codeField {
    if (!_codeField) {
        UITextField *textField = [UITextField new];
        textField.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textField.textColor = YYTextColor;
        textField.placeholder = @"请输入验证码";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(130), RELATIVE_WIDTH(40))];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.text = @"验证码";
        textField.leftView = label;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.returnKeyType = UIReturnKeyNext;
        textField.delegate = self;
        [self.contentView addSubview:textField];
        _codeField = textField;
    }
    return _codeField;
}

- (UITextField *)passWordField {
    if (!_passWordField) {
        UITextField *textField = [UITextField new];
        textField.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textField.textColor = YYTextColor;
        textField.placeholder = @"请输入密码";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(130), RELATIVE_WIDTH(40))];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.text = @"密码";
        textField.leftView = label;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.secureTextEntry = YES;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        [self.contentView addSubview:textField];
        _passWordField = textField;
    }
    return _passWordField;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"发送验证码" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.backgroundColor = YYGlobalColor;
        [button addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _sendButton = button;
    }
    return _sendButton;
}

- (UIButton *)seeButton {
    if (!_seeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_see"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"login_Closeyoureyes"] forState:UIControlStateSelected];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(seeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _seeButton = button;
    }
    return _seeButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard) name:YYHideKeyboardNotification object:nil];
    }
    return self;
}

- (void)hideKeyBoard
{
    switch (_type) {
        case YYLoginViewCellTypePhone:
            [self.phoneField resignFirstResponder];
            break;
        case YYLoginViewCellTypeCode:
            [self.codeField resignFirstResponder];
            break;
        case YYLoginViewCellTypePassword:
            [self.passWordField resignFirstResponder];
            break;
        default:
            break;
    }
}

- (void)sendAction
{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.sendButton setTitle:@"发送手机验证码" forState:UIControlStateNormal];
                [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.sendButton.enabled = YES;
                self.sendButton.backgroundColor = YYGlobalColor;
            });
        } else {
            int seconds = 60;
            if (timeout == 60) {
                seconds = 60;
            } else {
                seconds = timeout % 60;
            }
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.enabled = NO;
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.sendButton setTitle:[NSString stringWithFormat:@"%@秒后再次获取", strTime] forState:UIControlStateDisabled];
                self.sendButton.backgroundColor = YYDisableColor;
                [UIView commitAnimations];
                
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}

- (void)seeAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.passWordField.secureTextEntry = !sender.isSelected;
    
}

- (void)setType:(YYLoginViewCellType)type
{
    _type = type;
    WS(ws);
    switch (type) {
        case YYLoginViewCellTypePassword:
        {
            [self.seeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(60));
                make.centerY.equalTo(ws.contentView);
                make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(44), RELATIVE_WIDTH(44)));
            }];
            [self.passWordField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
                make.right.equalTo(self.seeButton.mas_left).offset(-RELATIVE_WIDTH(4));
                make.top.bottom.equalTo(ws.contentView);
            }];
        }
            break;
        case YYLoginViewCellTypePhone:
        {
            [self.phoneField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
                make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
                make.top.bottom.equalTo(ws.contentView);
            }];
        }
            break;
        case YYLoginViewCellTypeCode:
        {
            [self.sendButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
                make.centerY.equalTo(ws.contentView);
                make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(240), RELATIVE_WIDTH(60)));
            }];
            
            [self.codeField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
                make.right.equalTo(self.sendButton.mas_left).offset(-RELATIVE_WIDTH(4));
                make.top.bottom.equalTo(ws.contentView);
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string];
    switch (_type) {
        case YYLoginViewCellTypeCode:
        {
            if (current.length > 6) {
                if (_codeTextFieldBlock) {
                    _codeTextFieldBlock(_codeField.text);
                }
                return NO;
            } else {
                if (_codeTextFieldBlock) {
                    _codeTextFieldBlock(current);
                }
            }
            
        }
            break;
        case YYLoginViewCellTypePhone:
        {
            
            if (current.length > 11) {
                if (_phoneTextFieldBlock) {
                    _phoneTextFieldBlock(_phoneField.text);
                }
                return NO;
            } else {
                if (_phoneTextFieldBlock) {
                    _phoneTextFieldBlock(current);
                }
            }
            
        }
            break;
        case YYLoginViewCellTypePassword:
        {
            if (current.length > 10) {
                if (_passwordTextFieldBlock) {
                    _passwordTextFieldBlock(_passWordField.text);
                }
                return NO;
            } else {
                if (_passwordTextFieldBlock) {
                    _passwordTextFieldBlock(current);
                }
            }
        }
            break;
        default:
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_type == YYLoginViewCellTypePassword) {
        [self.passWordField resignFirstResponder];
    }
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
