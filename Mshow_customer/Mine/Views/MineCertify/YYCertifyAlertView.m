//
//  YYCertifyAlertView.m
//  Mshow_customer
//
//  Created by YYZ on 2018/1/2.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import "YYCertifyAlertView.h"
#import "UILabel+YYExtension.h"

@interface YYCertifyAlertView () <UITextFieldDelegate>
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic, weak) UITextField *codeField;

@end

@implementation YYCertifyAlertView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.text = @"请验证身份";
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(32)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = CertifyInfo;
        label.numberOfLines = 0;
        [UILabel changeLineSpaceForLabel:label WithSpace:RELATIVE_WIDTH(10)];
        [self addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}

- (UITextField *)nameField {
    if (!_nameField) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(24), 0, WIN_WIDTH - RELATIVE_WIDTH(48), RELATIVE_WIDTH(80))];
        field.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        field.backgroundColor = [UIColor whiteColor];
        field.placeholder = @"请输入真实姓名";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(160), RELATIVE_WIDTH(80))];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"姓名";
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        field.leftView = label;
        field.leftViewMode = UITextFieldViewModeAlways;
        field.returnKeyType = UIReturnKeyNext;
        field.delegate = self;
        [self addSubview:field];
        _nameField = field;
    }
    return _nameField;
}

- (UITextField *)codeField {
    if (!_codeField) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(24), 0, WIN_WIDTH - RELATIVE_WIDTH(48), RELATIVE_WIDTH(80))];
        field.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        field.backgroundColor = [UIColor whiteColor];
        field.placeholder = @"请输入身份证号";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(160), RELATIVE_WIDTH(80))];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"身份证号";
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        field.leftView = label;
        field.leftViewMode = UITextFieldViewModeAlways;
        field.returnKeyType = UIReturnKeyDone;
        field.delegate = self;
        [self addSubview:field];
        _codeField = field;
    }
    return _codeField;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(30));
            make.centerX.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(14));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(14));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(14));
            make.height.greaterThanOrEqualTo(@18);
        }];
    
        [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(6));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        
        [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.codeField.mas_top).offset(-RELATIVE_WIDTH(10));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.nameField) {
        if (_nameBlock) {
            _nameBlock(current);
        }
    }
    
    if (textField == self.codeField) {
        if (_codeBlock) {
            _codeBlock(current);
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameField) {
        [self.codeField resignFirstResponder];
    }
    return YES;
}

@end
