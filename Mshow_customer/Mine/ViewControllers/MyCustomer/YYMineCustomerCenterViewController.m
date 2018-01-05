//
//  YYMineCustomerCenterViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCustomerCenterViewController.h"
#import "YYMineCustomerCenterView.h"
#import "YYAllQuestionViewController.h"
#import "YYDeviceHandle.h"

#define phone_number @"02583412930"

@interface YYMineCustomerCenterViewController () <YYMineCustomerCenterViewDelegate>
@property (nonatomic, weak) YYMineCustomerCenterView *customerView;

@end

@implementation YYMineCustomerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服中心";
    YYMineCustomerCenterView *view = [[YYMineCustomerCenterView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _customerView = view;
}

#pragma mark - YYMineCustomerCenterViewDelegate
- (void)executeShowAllQuestion
{
    [self.navigationController pushViewController:[YYAllQuestionViewController new] animated:YES];
}

- (void)executeShowQuestion:(NSString *)questionID
{
    MJExtensionLog(@"%@", questionID);
}

- (void)executeCall
{
    [YYDeviceHandle makeCall:phone_number];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
