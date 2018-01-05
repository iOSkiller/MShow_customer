//
//  YYMineEditeViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineAddressEditeViewCell.h"

@interface YYMineAddressEditeViewCell () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic, weak) UITextField *phoneField;
@property (nonatomic, weak) UITextField *addressField;
@property (nonatomic, weak) UIButton *womanButton;
@property (nonatomic, weak) UIButton *manButton;

@end

@implementation YYMineAddressEditeViewCell

- (UITextField *)nameField {
    if (!_nameField) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(140), 0, self.mj_w - RELATIVE_WIDTH(170), RELATIVE_WIDTH(90))];
        field.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        field.backgroundColor = [UIColor whiteColor];
//        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.placeholder = @"请填写收货人的姓名";
        field.returnKeyType = UIReturnKeyNext;
        [self.contentView addSubview:field];
        _nameField = field;
    }
    return _nameField;
}

- (UITextField *)phoneField {
    if (!_phoneField) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(140), 0, self.mj_w - RELATIVE_WIDTH(170), RELATIVE_WIDTH(90))];
        field.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        field.backgroundColor = [UIColor whiteColor];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.keyboardType = UIKeyboardTypePhonePad;
        field.placeholder = @"请输入收货人手机号";
        field.returnKeyType = UIReturnKeyNext;
        [self.contentView addSubview:field];
        _phoneField = field;
    }
    return _phoneField;
}

- (UITextField *)addressField {
    if (!_addressField) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(140), 0, self.mj_w - RELATIVE_WIDTH(170), RELATIVE_WIDTH(120))];
        field.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        field.backgroundColor = [UIColor whiteColor];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.placeholder = @"例:5号楼701室";
        field.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:field];
        _addressField = field;
    }
    return _addressField;
}

- (UIButton *)womanButton {
    if (!_womanButton) {
        UIButton *womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        womanButton.layer.cornerRadius = CommonCornerRadius;
        womanButton.layer.borderColor = YYGrayTextColor.CGColor;
        womanButton.layer.borderWidth = RELATIVE_WIDTH(2);
        womanButton.layer.masksToBounds = YES;
        womanButton.backgroundColor = [UIColor whiteColor];
        [womanButton setTitle:@"女士" forState:UIControlStateNormal];
        [womanButton setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [womanButton setTitleColor:YYGlobalColor forState:UIControlStateSelected];
        womanButton.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [womanButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        womanButton.tag = 200;
        [self.contentView addSubview:womanButton];
        _womanButton = womanButton;
    }
    return _womanButton;
}

- (UIButton *)manButton {
    if (!_manButton) {
        UIButton *manButton = [UIButton buttonWithType:UIButtonTypeCustom];
        manButton.layer.cornerRadius = CommonCornerRadius;
        manButton.layer.borderColor = YYGrayTextColor.CGColor;
        manButton.layer.borderWidth = RELATIVE_WIDTH(2);
        manButton.layer.masksToBounds = YES;
        manButton.backgroundColor = [UIColor whiteColor];
        [manButton setTitle:@"男士" forState:UIControlStateNormal];
        [manButton setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [manButton setTitleColor:YYGlobalColor forState:UIControlStateSelected];
        manButton.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [manButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        manButton.tag = 201;
        [self.contentView addSubview:manButton];
        _manButton = manButton;
    }
    return _manButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = YYTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.detailTextLabel.textColor = YYGrayTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard) name:YYHideKeyboardNotification object:nil];
    }
    return self;
}

- (void)hideKeyBoard
{
    switch (_type) {
        case YYMineAddressEditeViewCellTypeName:
            [self.nameField resignFirstResponder];
            break;
        case YYMineAddressEditeViewCellTypePhone:
            [self.phoneField resignFirstResponder];
            break;
        case YYMineAddressEditeViewCellTypeDetailAddress:
            [self.addressField resignFirstResponder];
            break;
        default:
            break;
    }
}

- (void)setType:(YYMineAddressEditeViewCellType)type
{
    _type = type;
    switch (type) {
        case YYMineAddressEditeViewCellTypeName:
        {
            self.nameField.delegate = self;
            break;
        }
        case YYMineAddressEditeViewCellTypePhone:
        {
            self.phoneField.delegate = self;
            break;
        }
        case YYMineAddressEditeViewCellTypeGender:
        {
            [self womanButton];
            [self manButton];
            WS(ws);
            [self.womanButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(140));
                make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(50)));
                make.centerY.equalTo(ws.contentView);
            }];
            
            [self.manButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.womanButton.mas_right).offset(RELATIVE_WIDTH(40));
                make.centerY.width.height.equalTo(self.womanButton);
            }];
            break;
        }
        case YYMineAddressEditeViewCellTypeCity:
        {
            
            break;
        }
        case YYMineAddressEditeViewCellTypeDetailAddress:
        {
            self.addressField.delegate = self;
            break;
        }
    }
    
}

- (void)buttonAction:(UIButton *)sender
{
    if (sender == self.manButton) {
        self.manButton.selected = !sender.isSelected;
        self.womanButton.selected = !self.manButton.isSelected;
    } else {
        self.womanButton.selected = !sender.isSelected;
        self.manButton.selected = !self.womanButton.isSelected;
    }
    
    if (self.womanButton.isSelected) {
        self.womanButton.layer.borderColor = YYGlobalColor.CGColor;
        [self.womanButton layoutIfNeeded];
        self.manButton.layer.borderColor = YYGrayTextColor.CGColor;
        [self.manButton layoutIfNeeded];
    } else {
        self.womanButton.layer.borderColor = YYGrayTextColor.CGColor;
        [self.womanButton layoutIfNeeded];
        self.manButton.layer.borderColor = YYGlobalColor.CGColor;
        [self.manButton layoutIfNeeded];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (_type) {
        case YYMineAddressEditeViewCellTypeName:
            if (_nameBlock) {
                _nameBlock(current);
            }
            break;
        case YYMineAddressEditeViewCellTypePhone:
            if (_phoneBlock) {
                _phoneBlock(current);
            }
            break;
        case YYMineAddressEditeViewCellTypeDetailAddress:
            if (_detailAddressBlock) {
                _detailAddressBlock(current);
            }
            break;
        
        default:
            break;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_type == YYMineAddressEditeViewCellTypeDetailAddress) {
        [self.addressField resignFirstResponder];
    }
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
