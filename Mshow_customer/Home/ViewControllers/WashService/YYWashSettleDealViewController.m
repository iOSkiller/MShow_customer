//
//  YYWashSettleDealViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWashSettleDealViewController.h"
#import "YYSettleWashDealView.h"
#import "YYCartAccountView.h"
#import "YYSelectWashShopViewController.h"
#import "YYShopModel.h"
#import "YYPayDealViewController.h"
#import "YYMineAddressManagerViewController.h"
#import "YYAlertView.h"

@interface YYWashSettleDealViewController () <YYCartAccountViewDelegate, YYSettleWashDealViewDelegate>
@property (nonatomic, weak) YYSettleWashDealView *settleView;
@property (nonatomic, weak) YYCartAccountView *cartView;

@end

@implementation YYWashSettleDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算中心";
    self.view.backgroundColor = [UIColor whiteColor];
    YYSettleWashDealView *view = [[YYSettleWashDealView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100))];
    view.delegate = self;
    [self.view addSubview:view];
    _settleView = view;
    
    YYCartAccountView *cartView = [[YYCartAccountView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100))];
    cartView.isShowSelected = NO;
    cartView.totalPrice = @"200.00";
    [cartView setButtonTitle:@"提交订单"];
    cartView.delegate = self;
    [self.view addSubview:cartView];
    _cartView = cartView;
}

#pragma mark - YYSettleWashDealViewDelegate
- (void)executeSelectWashShop
{
    YYSelectWashShopViewController *selectWashShopVC = [YYSelectWashShopViewController new];
    WS(weakSelf);
    selectWashShopVC.didSelectWashShopBlock = ^(YYShopModel *shopModel) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.settleView.shop = shopModel.shopName;
    };
    [self.navigationController pushViewController:selectWashShopVC animated:YES];
}

- (void)executeSelectShipAddress
{
    YYMineAddressManagerViewController *addressVC = [YYMineAddressManagerViewController new];
    WS(weakSelf);
    addressVC.didSelectAddressBlock = ^(YYAddressModel *addressModel) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.settleView.shipAddressModel = addressModel;
    };
    [self.navigationController pushViewController:addressVC animated:YES];
}

- (void)executeSelectTakeAddress
{
    YYMineAddressManagerViewController *addressVC = [YYMineAddressManagerViewController new];
    WS(weakSelf);
    addressVC.didSelectAddressBlock = ^(YYAddressModel *addressModel) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.settleView.takeAddressModel = addressModel;
    };
    [self.navigationController pushViewController:addressVC animated:YES];
}

#pragma mark - YYCartAccountViewDelegate
- (void)executePay
{
    YYAlertView *alertView = [[YYAlertView alloc] initWithType:YYAlertViewTypeCertify];
    [alertView show];
    WS(weakSelf);
    alertView.certifyBlock = ^(NSString *name, NSString *code) {
        YYPayDealViewController *payVC = [YYPayDealViewController new];
        payVC.type = YYPayDealViewControllerTypeSubscribe;
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.navigationController pushViewController:payVC animated:YES];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
