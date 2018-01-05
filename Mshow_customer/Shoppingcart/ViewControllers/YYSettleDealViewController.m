//
//  YYSettleDealViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSettleDealViewController.h"
#import "YYSettleDealView.h"
#import "YYCartAccountView.h"
#import "YYShopModel.h"
#import "YYAddressModel.h"
#import "YYPayDealViewController.h"
#import "YYSelectDurationViewController.h"
#import "YYDealSettleHandle.h"
#import "NSDate+YYExtension.h"
#import "YYMineAddressManagerViewController.h"

@interface YYSettleDealViewController () <YYCartAccountViewDelegate, YYSettleDealViewDelegate>
@property (nonatomic, weak) YYSettleDealView *settleView;
@property (nonatomic, weak) YYCartAccountView *cartView;

@end

@implementation YYSettleDealViewController

{
    NSDate *_dateForRecieve;
}

- (YYCartAccountView *)cartView {
    if (!_cartView) {
        YYCartAccountView *view = [[YYCartAccountView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - RELATIVE_WIDTH(100) - iPhone_ProtraitDisableViewHeight - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100))];
        view.isShowSelected = NO;
        view.delegate = self;
        [self.view addSubview:view];
        _cartView = view;
    }
    return _cartView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算中心";
    self.view.backgroundColor = [UIColor whiteColor];
    YYSettleDealView *view = [[YYSettleDealView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM)];
    view.delegate = self;
    [self.view addSubview:view];
    _settleView = view;
    _settleView.goodsArray = [YYShopModel testDataArray];
    [self cartView];
    self.cartView.totalPrice = @"870";
    MBProgressHUD *hud = [self showHudProgress];
    [YYDealSettleHandle executeSettleDeal:@[] success:^(id obj) {
        [hud hide:YES];
    } failed:^(id failed) {
        [self showMessage:failed hud:hud duration:1.2];
    }];
}

#pragma mark - YYCartAccountViewDelegate
- (void)executePay
{
    MBProgressHUD *hud = [self showHudProgress];
    [YYDealSettleHandle executeMakeDeal:@"" addressId:@"" date:_dateForRecieve bonusScore:@"" buyRemark:@"" success:^(id obj) {
        [hud hide:YES];
        YYPayDealViewController *payVC = [[YYPayDealViewController alloc] init];
        payVC.dealModel = obj;
        [self.navigationController pushViewController:payVC animated:YES];
    } failed:^(id failed) {
        [self showMessage:failed hud:hud duration:1.2];
    }];
    
}

#pragma mark - YYSettleDealViewDelegate
- (void)executeSelectAddress
{
    YYMineAddressManagerViewController *addressVC = [YYMineAddressManagerViewController new];
    WS(weakSelf);
    addressVC.didSelectAddressBlock = ^(YYAddressModel *addressModel) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.settleView.addressModel = addressModel;
    };
    [self.navigationController pushViewController:addressVC animated:YES];
}

- (void)executeSelectDuration:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath
{
    YYSelectDurationViewController *selectDurationVC = [[YYSelectDurationViewController alloc] init];
    [selectDurationVC setType:YYSelectRentDurationViewTypeDuration dateForRecieve:_dateForRecieve];
    WS(weakSelf);
    selectDurationVC.didFinishSelectDuration = ^(NSUInteger days, NSString *dateForRecieve) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.settleView updateDuration:[NSString stringWithFormat:@"%@", @(days)] shop:shopModel indexPath:indexPath];
    };
    [self.navigationController pushViewController:selectDurationVC animated:YES];
}

- (void)executeSelectDateForRecieve
{
    YYSelectDurationViewController *selectDurationVC = [[YYSelectDurationViewController alloc] init];
    [selectDurationVC setType:YYSelectRentDurationViewTypeDate dateForRecieve:_dateForRecieve];
    WS(weakSelf);
    selectDurationVC.didFinishSelectDuration = ^(NSUInteger days, NSString *dateForRecieve) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.settleView.dateForRecieve = dateForRecieve;
        _dateForRecieve = [NSDate dateFromString:dateForRecieve dateFormate:@"yyyy-MM-dd"];
    };
    [self.navigationController pushViewController:selectDurationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
