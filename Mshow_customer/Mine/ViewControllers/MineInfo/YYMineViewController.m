//
//  YYMineViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineViewController.h"
#import "YYMineView.h"
#import "YYMineInfoViewController.h"
#import "YYSettingViewController.h"
#import "YYMessageCenterViewController.h"
//#import "YYMyWardrobeViewController.h"
#import "YYDealViewController.h"
#import "YYMyCouponViewController.h"
#import "YYMyWalletViewController.h"
#import "YYHistoryViewController.h"
#import "YYCollectionViewController.h"
#import "YYMyCommentViewController.h"
#import "YYMineAddressManagerViewController.h"
#import "YYMineCertifyViewController.h"
#import "YYMineInvateViewController.h"
#import "YYMineCreditRateViewController.h"
#import "YYMineCustomerCenterViewController.h"
#import "YYReturnChangeGoodsListViewController.h"


#import "YYUserModel.h"

@interface YYMineViewController () <YYMineViewDelegate>
@property (nonatomic, weak) YYMineView *mineView;

@end

@implementation YYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    YYMineView *view = [[YYMineView alloc] initWithFrame:CGRectMake(0, kDevice_Is_iPhoneX ? 0 : -20, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight + (kDevice_Is_iPhoneX ? 0 : 44))];
    view.delegate = self;
    [view reloadCustomerInfo:nil];
    [self.view addSubview:view];
    _mineView = view;
    
    if (kDevice_Is_iPhoneX) {
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, iPhoneX_statusBarHeight)];
        statusView.backgroundColor = YYGlobalColor;
        [self.view addSubview:statusView];
        [self.view insertSubview:statusView aboveSubview:self.mineView];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - YYMineViewDelegate
- (void)executeShowFunctionDetail:(YYMineFunctionType)functionType
{
    if (!(mAppDelegate).isLogin) {
        [self executeLogin:^(YYUserModel *userModel) {
            
        }];
    } else {
        switch (functionType) {
            case YYMineFunctionTypeCoupon:
            {
                [self.navigationController pushViewController:[[YYMyCouponViewController alloc] init] animated:YES];
                break;
            }
            case YYMineFunctionTypeWallet:
            {
                [self.navigationController pushViewController:[YYMyWalletViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeHistory:
            {
                [self.navigationController pushViewController:[YYHistoryViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeCollection:
            {
                [self.navigationController pushViewController:[YYCollectionViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeComments:
            {
                [self.navigationController pushViewController:[YYMyCommentViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeInvite:
            {
                [self.navigationController pushViewController:[YYMineInvateViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeCreditRate:
            {
                [self.navigationController pushViewController:[YYMineCreditRateViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeAddress:
            {
                [self.navigationController pushViewController:[YYMineAddressManagerViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeCertify:
            {
                [self.navigationController pushViewController:[YYMineCertifyViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeCustomerServer:
            {
                [self.navigationController pushViewController:[YYMineCustomerCenterViewController new] animated:YES];
                break;
            }
            case YYMineFunctionTypeChange:
            {
                [self.navigationController pushViewController:[YYReturnChangeGoodsListViewController new] animated:YES];
                break;
            }
            default:
                break;
        }
    }
    
}

- (void)executeShowDealDetail:(YYDealStatusType)dealStatus
{
    if ((mAppDelegate).isLogin) {
        NSInteger index = 0;
        switch (dealStatus) {
            case YYDealStatusTypeWaitForPay:
                index = 1;
                break;
            case YYDealStatusTypeWaitForDelivery:
                index = 2;
                break;
            case YYDealStatusTypeWaitForRecieve:
                index = 3;
                break;
            case YYDealStatusTypeWaitForReturn:
                index = 4;
                break;
            case YYDealStatusTypeWaitForComment:
                index = 5;
                break;
            case YYDealStatusTypeWaitForSubmit:
                index = 6;
                break;
            default:
                break;
        }
        YYDealViewController *dealVC = [[YYDealViewController alloc] init];
        dealVC.selectIndex = index;
        [self.navigationController pushViewController:dealVC animated:YES];
    } else {
        [self executeLogin:^(YYUserModel *userModel) {
            
        }];
    }
}

- (void)executeShowInfoDetail
{
    if ((mAppDelegate).isLogin) {
        [self.navigationController pushViewController:[YYMineInfoViewController new] animated:YES];
    } else {
        WS(weakSelf);
        [self executeLogin:^(YYUserModel *userModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf.mineView reloadCustomerInfo:userModel];
        }];
        
        
        
    }
    
}

- (void)executeShowSetting
{
    YYSettingViewController *settingVC = [YYSettingViewController new];
    WS(weakSelf);
    settingVC.logoutBlock = ^{
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.mineView reloadCustomerInfo:nil];
    };
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)executeShowMessage
{
    if ((mAppDelegate).isLogin) {
        [self.navigationController pushViewController:[YYMessageCenterViewController new] animated:YES];
    } else {
        [self executeLogin:^(YYUserModel *userModel) {
            
        }];
    }
    
}

- (void)executeShowAllDeal
{
    if ((mAppDelegate).isLogin) {
        [self.navigationController pushViewController:[YYDealViewController new] animated:YES];
    } else {
        [self executeLogin:^(YYUserModel *userModel) {
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
