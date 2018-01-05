//
//  YYMyWalletViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyWalletViewController.h"
#import "YYMyWalletView.h"
#import "YYConsumerdetailsViewController.h"
#import "YYChargeBalanceViewController.h"
#import "YYWithDrawCashViewController.h"
#import "YYWalletQuestionViewController.h"

@interface YYMyWalletViewController () <YYMyWalletViewDelegate>
@property (nonatomic, weak) YYMyWalletView *walletView;

@end

@implementation YYMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    YYMyWalletView *view = [[YYMyWalletView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _walletView = view;
    
    [self setUpRightItem:@"明细" selectedTitle:nil image:@"" highImage:@"" target:self action:@selector(showConsumerdetails)];
    WS(ws);
    [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(ws.view.safeAreaInsets);
        } else {
            make.edges.equalTo(ws.view);
        }
    }];
}

- (void)showConsumerdetails
{
    [self.navigationController pushViewController:[YYConsumerdetailsViewController new] animated:YES];
}

#pragma mark - YYMyWalletViewDelegate
- (void)executeShowHelp
{
    [self.navigationController pushViewController:[YYWalletQuestionViewController new] animated:YES];
}

- (void)executeCharge
{
    [self.navigationController pushViewController:[YYChargeBalanceViewController new] animated:YES];
}

- (void)executeWithDrawCash
{
    [self.navigationController pushViewController:[YYWithDrawCashViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
