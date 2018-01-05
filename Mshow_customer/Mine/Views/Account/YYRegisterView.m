//
//  YYRegisterView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYRegisterView.h"
#import "YYRegisterViewCell.h"

@interface YYRegisterView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UILabel *infoLabel;

@end

@implementation YYRegisterView

{
    NSString *_phone;
    NSString *_code;
    NSString *_password;
    NSString *_repassword;
    YYRegisterViewType _type;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.backgroundColor = YYSeparatorColor;
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame type:(YYRegisterViewType)type
{
    if (self = [super initWithFrame:frame]) {
        _type = type;
        self.backgroundColor = YYSeparatorColor;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(40))];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(200))];
        footerView.backgroundColor = YYSeparatorColor;
        self.tableView.tableFooterView = footerView;
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        sureButton.enabled = NO;
        sureButton.backgroundColor = YYDisableColor;
        sureButton.layer.cornerRadius = CommonCornerRadius;
        sureButton.layer.masksToBounds = YES;
        [sureButton setTitle:_type == YYRegisterViewTypeResetCode ? @"确认修改" : @"立即注册" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:sureButton];
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerView).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(footerView).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
            make.top.equalTo(footerView).offset(RELATIVE_WIDTH(40));
        }];
        _sureButton = sureButton;
        
        if (_type == YYRegisterViewTypeRegister) {
            UILabel *label = [UILabel new];
            label.backgroundColor = YYSeparatorColor;
            label.attributedText = [NSString str1:@"注册代表您同意" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(24)] color1:YYGrayTextColor str2:@"《M秀用户协议》" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(24)] color2:YYGlobalColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
            [label addGestureRecognizer:tap];
            label.userInteractionEnabled = YES;
            [footerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(footerView);
                make.top.equalTo(sureButton.mas_bottom).offset(RELATIVE_WIDTH(20));
                make.height.mas_equalTo(RELATIVE_WIDTH(26));
                make.width.greaterThanOrEqualTo(@0);
            }];
        }
    }
    return self;
}

- (void)sureAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeSureAction:password:code:)]) {
        [_delegate executeSureAction:_phone password:_password code:_code];
    }
}

- (void)tapAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowProtocol)]) {
        [_delegate executeShowProtocol];
    }
}

- (void)updateInfo
{
    if ([_password isValid] && [_repassword isValid]) {
        if ([_code isValid] &&
            [_phone isValidateMobile] &&
            [_password isEqualToString:_repassword]) {
            _sureButton.enabled = YES;
        } else {
            _sureButton.enabled = NO;
        }
    } else {
        _sureButton.enabled = NO;
    }
    
    _sureButton.backgroundColor = _sureButton.enabled ? YYGlobalColor : YYDisableColor;
}

- (void)beginTimer
{
    YYRegisterViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell beginTimer];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    YYRegisterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYRegisterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        WS(weakSelf);
        switch (indexPath.row) {
            case 0:
            {
                cell.type = YYRegisterViewCellTypePhone;
                cell.phoneTextFieldBlock = ^(NSString *phone) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    _phone = phone;
                    [strongSelf updateInfo];
                };
            }
                break;
            case 1:
            {
                cell.type = YYRegisterViewCellTypeCode;
                cell.codeTextFieldBlock = ^(NSString *code) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    _code = code;
                    [strongSelf updateInfo];
                };
                cell.sendPhoneCodeBlock = ^{
                    if (_delegate && [_delegate respondsToSelector:@selector(executeSendPhoneCode:)]) {
                        [_delegate executeSendPhoneCode:_phone];
                    }
                };
            }
                break;
            case 2:
            {
                cell.type = _type == YYRegisterViewTypeRegister ? YYRegisterViewCellTypePassword : YYRegisterViewCellTypeNewPassword ;
                cell.passwordTextFieldBlock = ^(NSString *password) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    _password = password;
                    [strongSelf updateInfo];
                };
            }
                break;
            case 3:
            {
                cell.type = YYRegisterViewCellTypeRePassword;
                cell.repasswordTextFiedBlock = ^(NSString *repassword) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    _repassword = repassword;
                    [strongSelf updateInfo];
                };
            }
                break;
            default:
                break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(120);
}

@end
