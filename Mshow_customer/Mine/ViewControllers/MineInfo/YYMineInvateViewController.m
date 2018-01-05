//
//  YYMineInvateViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateViewController.h"
#import "YYMineInvateView.h"
#import "YYMineInvateHistoryViewController.h"

@interface YYMineInvateViewController () <YYMineInvateViewDelegate>
@property (nonatomic, weak) YYMineInvateView *invateView;

@end

@implementation YYMineInvateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请有奖";
    self.view.backgroundColor = [UIColor whiteColor];
    YYMineInvateView *invateView = [[YYMineInvateView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    invateView.delegate = self;
    [self.view addSubview:invateView];
    _invateView = invateView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YYMineInvateViewDelegate
- (void)executeInvateFriend:(NSString *)invateCode
{
    
}

- (void)executeShowInvateConsolation
{
    [self.navigationController pushViewController:[YYMineInvateHistoryViewController new] animated:YES];
}


@end
