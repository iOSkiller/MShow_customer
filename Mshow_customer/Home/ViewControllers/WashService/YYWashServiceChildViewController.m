//
//  YYWashServiceChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWashServiceChildViewController.h"
#import "YYWashServiceView.h"
#import "YYCartAccountView.h"
#import "YYWashSettleDealViewController.h"

@interface YYWashServiceChildViewController () <YYCartAccountViewDelegate>
@property (nonatomic, weak) YYWashServiceView *washServiceView;
@property (nonatomic, weak) YYCartAccountView *cartView;

@end

@implementation YYWashServiceChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    YYWashServiceView *view = [[YYWashServiceView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - RELATIVE_WIDTH(80) - iPhone_MARGIN_BOTTOM) type:_type];
    [self.view addSubview:view];
    _washServiceView = view;
    
    YYCartAccountView *cartView = [[YYCartAccountView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(80) - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100))];
    cartView.isShowSelected = NO;
    cartView.totalPrice = @"200.00";
    cartView.delegate = self;
    [self.view addSubview:cartView];
    _cartView = cartView;
    
}

#pragma mark - YYCartAccountViewDelegate
- (void)executePay
{
    YYWashSettleDealViewController *settleVC = [YYWashSettleDealViewController new];
    [self.navigationController pushViewController:settleVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
