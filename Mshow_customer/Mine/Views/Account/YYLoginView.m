//
//  YYLoginView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYLoginView.h"
#import "YYThirdLoginView.h"
#import "YYLoginViewCell.h"

@interface YYLoginView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIButton *sureButton;
@end

@implementation YYLoginView

{
    NSString *_phone;
    NSString *_code;
    NSString *_password;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        view.separatorColor = YYGrayTextColor;
        view.separatorInset = UIEdgeInsetsMake(0, RELATIVE_WIDTH(26), 0, RELATIVE_WIDTH(26));
        view.layoutMargins = UIEdgeInsetsMake(0, RELATIVE_WIDTH(26), 0, RELATIVE_WIDTH(26));
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(396))];
        headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
        [headerView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(240), RELATIVE_WIDTH(240)));
            make.top.equalTo(headerView).offset(RELATIVE_WIDTH(100));
            make.centerX.equalTo(headerView);
        }];
        self.tableView.tableHeaderView = headerView;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(750))];
        footerView.backgroundColor = [UIColor whiteColor];
        footerView.userInteractionEnabled = YES;
        
        UILabel *forgetButton = [UILabel new];
        forgetButton.textColor = YYGrayTextColor;
        forgetButton.text = @"忘记密码？";
        forgetButton.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        forgetButton.backgroundColor = [UIColor whiteColor];
        forgetButton.userInteractionEnabled = YES;
        UITapGestureRecognizer *forgetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetAction)];
        [forgetButton addGestureRecognizer:forgetTap];
        [footerView addSubview:forgetButton];
        
        [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.width.greaterThanOrEqualTo(@0);
            make.left.equalTo(footerView).offset(RELATIVE_WIDTH(26));
        }];
        
        UILabel *registerButton = [UILabel new];
        registerButton.text = @"立即注册";
        registerButton.textColor = YYGrayTextColor;
        registerButton.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        registerButton.textAlignment = NSTextAlignmentRight;
        registerButton.backgroundColor = [UIColor whiteColor];
        registerButton.userInteractionEnabled = YES;
        UITapGestureRecognizer *registerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerAction)];
        [registerButton addGestureRecognizer:registerTap];
        [footerView addSubview:registerButton];
        
        [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.width.greaterThanOrEqualTo(@0);
            make.right.equalTo(footerView).offset(-RELATIVE_WIDTH(26));
        }];
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        sureButton.backgroundColor = YYDisableColor;
        sureButton.layer.cornerRadius = CommonCornerRadius;
        sureButton.layer.masksToBounds = YES;
        sureButton.enabled = NO;
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:sureButton];
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerView).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(footerView).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
            make.top.equalTo(footerView).offset(RELATIVE_WIDTH(140));
        }];
        _sureButton = sureButton;
        
        WS(weakSelf);
        YYThirdLoginView *thirdView = [[YYThirdLoginView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(200))];
        thirdView.loginSuccessBlock = ^(NSString *platName, NSString *userID, NSString *nickName, NSString *headURL) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf loginByThirdWay:platName];
        };
        thirdView.loginFailedBlock = ^(NSString *message) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf showFaliedMessage:message];
        };
        [footerView addSubview:thirdView];
        [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(footerView);
            make.top.equalTo(sureButton.mas_bottom).offset(RELATIVE_WIDTH(100));
            make.height.mas_equalTo(RELATIVE_WIDTH(200));
        }];
        
        self.tableView.tableFooterView = footerView;
    }
    return self;
}



- (void)loginByThirdWay:(NSString *)loginType
{
    
}

- (void)showFaliedMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud hide:YES afterDelay:1.2];
}

- (void)updateInfo
{
    _sureButton.enabled = [_phone isValid] && [_password isValid];
    _sureButton.backgroundColor = _sureButton.enabled ? YYGlobalColor : YYDisableColor;
}

- (void)forgetAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeFindCode)]) {
        [_delegate executeFindCode];
    }
}

- (void)registerAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeRegister)]) {
        [_delegate executeRegister];
    }
}

- (void)sureAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeLogin:password:)]) {
        [_delegate executeLogin:_phone password:_password];
    }
    MJExtensionLog(@"phone:%@  code:%@   password:%@", _phone, _code, _password);
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    YYLoginViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYLoginViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row != 2) {
            cell = [[YYLoginViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.type = indexPath.row == 0 ? YYLoginViewCellTypePhone : YYLoginViewCellTypePassword;
            WS(weakSelf);
            cell.phoneTextFieldBlock = ^(NSString *phone) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                _phone = phone;
                [weakSelf updateInfo];
            };
            cell.passwordTextFieldBlock = ^(NSString *password) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                _password = password;
                [strongSelf updateInfo];
            };
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, RELATIVE_WIDTH(26), 0, RELATIVE_WIDTH(26))];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, RELATIVE_WIDTH(26), 0, RELATIVE_WIDTH(26))];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 0.000001;
    }
    return RELATIVE_WIDTH(80);
}

@end
