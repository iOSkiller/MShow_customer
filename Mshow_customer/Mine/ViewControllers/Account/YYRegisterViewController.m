//
//  YYRegisterViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYRegisterViewController.h"
#import "YYRegisterView.h"
#import "YYAccountHandle.h"

@interface YYRegisterViewController () <YYRegisterViewDelegate>
@property (nonatomic, weak) YYRegisterView *registerView;
@end

@implementation YYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _type == YYRegisterViewControllerTypeRegister ? @"注册" : @"修改密码";
    YYRegisterView *view = [[YYRegisterView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight) type:_type == YYRegisterViewControllerTypeRegister ? YYRegisterViewTypeRegister : YYRegisterViewTypeResetCode];
    view.delegate = self;
    [self.view addSubview:view];
    _registerView = view;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:YYHideKeyboardNotification object:nil];
}

#pragma mark - YYRegisterViewDelegate
- (void)executeSureAction:(NSString *)phone password:(NSString *)password code:(NSString *)code
{
    MBProgressHUD *hud = [self showHudProgress];
    if (_type == YYRegisterViewTypeRegister) {
        [YYAccountHandle executeRegister:phone password:password code:code success:^(id obj) {
            if (_registerSuccessBlock) {
                _registerSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(id failed) {
            [self showMessage:failed hud:hud duration:1.2];
        }];
    } else {
        [YYAccountHandle executeResetPassword:phone password:password code:code success:^(id obj) {
            if (_resetCodeSuccessBlock) {
                _resetCodeSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(id failed) {
            [self showMessage:failed hud:hud duration:1.2];
        }];
    }
}

- (void)executeShowProtocol
{
    
}

- (void)executeSendPhoneCode:(NSString *)phone
{
    MBProgressHUD *hud = [self showHudProgress];
    if (_type == YYRegisterViewTypeRegister) {
        [YYAccountHandle executeSendRegisterPhoneCode:phone success:^(id obj) {
            [self showMessage:obj hud:hud duration:1.2];
            [self.registerView beginTimer];
        } failed:^(id failed) {
            [self showMessage:failed hud:hud duration:1.2];
        }];
    } else {
        [YYAccountHandle executeSendResetPasswordPhoneCode:phone success:^(id obj) {
            [self showMessage:obj hud:hud duration:1.2];
            [self.registerView beginTimer];
        } failed:^(id failed) {
            [self showMessage:failed hud:hud duration:1.2];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
