//
//  YYPaySuccessViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYPaySuccessViewController.h"
#import "YYPaySuccessView.h"
#import "YYShoppingcartViewController.h"
#import "YYDealDetailViewController.h"
#import "YYDealViewController.h"
#import "YYDealModel.h"
#import "YYGoodsModel.h"

@interface YYPaySuccessViewController () <YYPaySuccessViewDelegate>
@property (nonatomic, weak) YYPaySuccessView *successView;

@end

@implementation YYPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_interactivePopDisabled = YES;
    
    [self setUpLeftItem:nil selectedTitle:nil image:@"img_arrow_left" highImage:@"img_arrow_left" target:self action:@selector(backAction)];
    
    YYPaySuccessView *view = [[YYPaySuccessView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _successView = view;
}

- (void)backAction
{
    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[YYShoppingcartViewController class]] ||
            [vc isKindOfClass:[YYDealViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

#pragma mark - YYPaySuccessViewDelegate
- (void)executeBackHome
{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)executeShowDeal
{
    YYDealDetailViewController *dealDetailVC = [YYDealDetailViewController new];
    YYDealModel *model = [YYDealModel testDeal];
    model.statusType = YYDealStatusTypeWaitForDelivery;
    dealDetailVC.dealModel = model;
    [self.navigationController pushViewController:dealDetailVC animated:YES];
}

- (void)executeShowGoodsModel:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
