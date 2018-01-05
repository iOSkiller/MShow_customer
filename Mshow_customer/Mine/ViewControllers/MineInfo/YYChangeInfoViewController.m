//
//  YYChangeInfoViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/5.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChangeInfoViewController.h"

@interface YYChangeInfoViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UITextField *phoneField;
@property (nonatomic, weak) UITextField *codeField;

@end

@implementation YYChangeInfoViewController

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确认修改" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        _sureButton = button;
    }
    return _sureButton;
}

- (UITextField *)textField {
    if (!_textField) {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(80), WIN_WIDTH, RELATIVE_WIDTH(80))];
        textFiled.backgroundColor = [UIColor whiteColor];
        textFiled.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textFiled.textColor = YYTextColor;
        textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(26), RELATIVE_WIDTH(80))];
        textFiled.leftView.backgroundColor = [UIColor whiteColor];
        textFiled.leftViewMode = UITextFieldViewModeAlways;
        
//        textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(26), RELATIVE_WIDTH(80))];
//        textFiled.rightView.backgroundColor = [UIColor whiteColor];
//        textFiled.rightViewMode = UITextFieldViewModeAlways;
        textFiled.delegate = self;
        [self.view addSubview:textFiled];
        _textField = textFiled;
    }
    return _textField;
}

- (UITextField *)phoneField {
    if (!_phoneField) {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(80), WIN_WIDTH, RELATIVE_WIDTH(80))];
        textFiled.backgroundColor = [UIColor whiteColor];
        textFiled.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textFiled.textColor = YYTextColor;
        textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(220), RELATIVE_WIDTH(80))];
        infoLabel.backgroundColor = [UIColor whiteColor];
        infoLabel.textColor = YYTextColor;
        infoLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        infoLabel.text = @"   新手机号";
        textFiled.leftView = infoLabel;
        textFiled.leftViewMode = UITextFieldViewModeAlways;
        
//        textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(26), RELATIVE_WIDTH(80))];
//        textFiled.rightView.backgroundColor = [UIColor whiteColor];
//        textFiled.rightViewMode = UITextFieldViewModeAlways;
        textFiled.delegate = self;
        textFiled.keyboardType = UIKeyboardTypePhonePad;
        [self.view addSubview:textFiled];
        _phoneField = textFiled;
    }
    return _phoneField;
}

- (UITextField *)codeField {
    if (!_codeField) {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(170), WIN_WIDTH, RELATIVE_WIDTH(80))];
        textFiled.backgroundColor = [UIColor whiteColor];
        textFiled.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textFiled.textColor = YYTextColor;
        textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(220), RELATIVE_WIDTH(80))];
        infoLabel.backgroundColor = [UIColor whiteColor];
        infoLabel.textColor = YYTextColor;
        infoLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        infoLabel.text = @"   验证码";
        textFiled.leftView = infoLabel;
        textFiled.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, RELATIVE_WIDTH(200), RELATIVE_WIDTH(80));
        button.backgroundColor = YYGlobalColor;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
        textFiled.rightView = button;
        textFiled.rightViewMode = UITextFieldViewModeAlways;
        textFiled.keyboardType = UIKeyboardTypePhonePad;
        textFiled.delegate = self;
        [self.view addSubview:textFiled];
        _codeField = textFiled;
    }
    return _codeField;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_type) {
        case YYMineInfoTypePhone:
            self.title = @"修改手机号";
            self.phoneField.placeholder = @"请输入新手机号";
            self.codeField.placeholder = @"请输入验证码";
            break;
        case YYMineInfoTypeHeight:
            self.title = @"修改身高";
            self.textField.placeholder = @"请输入身高";
            break;
        case YYMineInfoTypeNickname:
            self.title = @"修改昵称";
            self.textField.placeholder = @"请输入昵称";
            break;
        default:
            break;
    }
    self.sureButton.frame = CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(400), WIN_WIDTH - RELATIVE_WIDTH(52), RELATIVE_WIDTH(80));
    self.sureButton.enabled = NO;
    self.sureButton.backgroundColor = YYDisableColor;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.textField) {
        [self.textField resignFirstResponder];
    }
    
    if (self.phoneField) {
        [self.phoneField resignFirstResponder];
    }
    
    if (self.codeField) {
        [self.codeField resignFirstResponder];
    }
}

- (void)sureAction
{
    switch (_type) {
        case YYMineInfoTypeHeight:
        case YYMineInfoTypeNickname:
            if (_didFinishChangeInfoBlock) {
                _didFinishChangeInfoBlock(self.textField.text);
            }
            break;
        case YYMineInfoTypePhone:
            if (_didFinishChangeInfoBlock) {
                _didFinishChangeInfoBlock(self.phoneField.text);
            }
            break;
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)codeAction
{
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string];
    switch (_type) {
        case YYMineInfoTypeNickname:
            self.sureButton.enabled = [self.textField.text isValid];
            self.sureButton.backgroundColor = self.sureButton.enabled ? YYGlobalColor : YYDisableColor;
            break;
        case YYMineInfoTypeHeight:
            self.sureButton.enabled = [self.textField.text isValid];
            self.sureButton.backgroundColor = self.sureButton.enabled ? YYGlobalColor : YYDisableColor;
            break;
        case YYMineInfoTypePhone:
            if (textField == self.phoneField) {
                if (current.length > 11) {
                    self.sureButton.enabled = [current isValid] && [self.codeField.text isValid];
                    self.sureButton.backgroundColor = self.sureButton.enabled ? YYGlobalColor : YYDisableColor;
                    return NO;
                }
            } else if (textField == self.codeField) {
                self.sureButton.enabled = [current isValid] && [self.phoneField.text isValid];
                self.sureButton.backgroundColor = self.sureButton.enabled ? YYGlobalColor : YYDisableColor;
            }
            break;
        default:
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.codeField) {
        [self.codeField resignFirstResponder];
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
