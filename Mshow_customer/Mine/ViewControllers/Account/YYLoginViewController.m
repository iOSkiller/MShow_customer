//
//  YYLoginViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYLoginViewController.h"
#import "YYLoginView.h"
#import "YYRegisterViewController.h"
#import "YYAccountHandle.h"
#import "YYUserModel.h"

@interface YYLoginViewController () <YYLoginViewDelegate>
@property (nonatomic, weak) YYLoginView *loginView;

@end

@implementation YYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    YYLoginView *view = [[YYLoginView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _loginView = view;
    [self setUpLeftItem:nil selectedTitle:nil image:@"img_mistake" highImage:@"" target:self action:@selector(cancelAction)];
    
}

- (void)cancelAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YYHideKeyboardNotification object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - YYLoginViewDelegate
- (void)executeRegister
{
    YYRegisterViewController *registerVC = [YYRegisterViewController new];
    registerVC.type = YYRegisterViewControllerTypeRegister;
//    WS(weakSelf);
    registerVC.registerSuccessBlock = ^{
//        StrongSelf(strongSelf);
//        strongSelf = weakSelf;
//        [strongSelf showMessage:@"注册成功" hud:nil duration:1.0];
//        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)executeFindCode
{
    YYRegisterViewController *registerVC = [YYRegisterViewController new];
    registerVC.type = YYRegisterViewControllerTypeResetCode;
//    WS(weakSelf);
    registerVC.resetCodeSuccessBlock = ^{
//        StrongSelf(strongSelf);
//        strongSelf = weakSelf;
//        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)executeLogin:(NSString *)phone password:(NSString *)password
{
    MBProgressHUD *hud = [self showHudProgress];
    [YYAccountHandle executeLogin:phone password:password success:^(id obj) {
        [hud hide:YES];
        YYUserModel *model = obj;
        (mAppDelegate).isLogin = YES;
        (mAppDelegate).userID = model.userId;
        (mAppDelegate).userName = model.userName;
        if (_loginSuccessBlock) {
            _loginSuccessBlock(model);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } failed:^(id failed) {
        [self showMessage:failed hud:hud duration:1.2];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
