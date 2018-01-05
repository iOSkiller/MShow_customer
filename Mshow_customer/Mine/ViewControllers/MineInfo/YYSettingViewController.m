//
//  YYSettingViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSettingViewController.h"
#import "YYSettingView.h"
#import "YYUserDefaultHandle.h"
#import "YYRegisterViewController.h"
#import "YYUserModel.h"

@interface YYSettingViewController () <YYSettingViewDelegate>
@property (nonatomic, weak) YYSettingView *settingView;

@end

@implementation YYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    YYSettingView *settingView = [[YYSettingView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    settingView.delegate = self;
    [self.view addSubview:settingView];
    _settingView = settingView;
    
}

#pragma mark - YYSettingViewDelegate
- (void)executeResetPassword
{
    if ((mAppDelegate).isLogin) {
        YYRegisterViewController *resetCodeVC = [YYRegisterViewController new];
        resetCodeVC.type = YYRegisterViewControllerTypeResetCode;
        
        resetCodeVC.resetCodeSuccessBlock = ^{
            
        };
        [self.navigationController pushViewController:resetCodeVC animated:YES];
    } else {
        [self showMessage:@"请先登录" hud:nil duration:1.2];
    }
}

- (void)executeCleanMemmory
{
    
}

- (void)executeShowMshow
{
    
}

- (void)executeLogout
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        (mAppDelegate).isLogin = NO;
        [YYUserDefaultHandle cleanUserDefaultInfo];
        if (_logoutBlock) {
            _logoutBlock();
        }
        [self.settingView logouSuccess];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
