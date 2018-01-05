//
//  YYMineCertifyViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCertifyViewCell.h"

@interface YYMineCertifyViewCell () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic, weak) UITextField *codeField;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *infoLabel;

@end

@implementation YYMineCertifyViewCell

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
        [self.contentView addSubview:field];
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
        [self.contentView addSubview:field];
        _codeField = field;
    }
    return _codeField;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(24), RELATIVE_WIDTH(30), RELATIVE_WIDTH(20), RELATIVE_WIDTH(20))];
        view.layer.cornerRadius = RELATIVE_WIDTH(10);
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(54), 0, WIN_WIDTH - RELATIVE_WIDTH(74), RELATIVE_WIDTH(80))];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGlobalColor;
        label.text = @"为了保障您的账户安全，请进行实名认证";
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [self.contentView addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
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
        case YYMineCertifyViewCellTypeCode:
            [self.codeField resignFirstResponder];
            break;
        case YYMineCertifyViewCellTypeName:
            [self.nameField resignFirstResponder];
            break;
        default:
            break;
    }
}

- (void)setType:(YYMineCertifyViewCellType)type
{
    _type = type;
    switch (type) {
        case YYMineCertifyViewCellTypeName:
            [self nameField];
            break;
        case YYMineCertifyViewCellTypeCode:
            [self codeField];
            break;
        case YYMineCertifyViewCellTypeInfo:
            [self imgView];
            [self infoLabel];
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (_type == YYMineCertifyViewCellTypeName) {
        if (_nameBlock) {
            _nameBlock(current);
        }
    }
    
    if (_type == YYMineCertifyViewCellTypeCode) {
        if (_codeBlock) {
            _codeBlock(current);
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_type == YYMineCertifyViewCellTypeCode) {
        [self.codeField resignFirstResponder];
    }
    return YES;
}

@end
