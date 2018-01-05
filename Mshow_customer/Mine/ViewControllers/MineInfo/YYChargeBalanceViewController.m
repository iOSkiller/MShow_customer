//
//  YYChargeBalance ViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChargeBalanceViewController.h"
#import "YYChargeBalanceView.h"

@interface YYChargeBalanceViewController () <YYChargeBalanceViewDelegate>
@property (nonatomic, weak) YYChargeBalanceView *chargeView;

@end

@implementation YYChargeBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值余额";
    self.view.backgroundColor = YYSeparatorColor;
    YYChargeBalanceView *view = [[YYChargeBalanceView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _chargeView = view;
}

#pragma mark - YYChargeBalanceViewDelegate
- (void)executeChangeBalance:(NSString *)balanceSum paytype:(YYPayType)paytype
{
    MJExtensionLog(@"%@%@", balanceSum, paytype == YYPayTypeAlipay ? @"支付宝支付" : @"微信支付");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
