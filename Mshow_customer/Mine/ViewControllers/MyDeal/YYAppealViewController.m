//
//  YYAppealViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYAppealViewController.h"
#import "YYAppealDealView.h"
#import "YYDealModel.h"

@interface YYAppealViewController () <YYAppealDealViewDelegate>

@end

@implementation YYAppealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申诉";
    self.view.backgroundColor = [UIColor whiteColor];
    YYAppealDealView *appealView = [[YYAppealDealView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    appealView.delegate = self;
    [self.view addSubview:appealView];
}

#pragma mark - YYAppealDealViewDelegate
- (void)executeCancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)executeSureAction:(YYDealModel *)dealModel
{
    if (_didFinishAppealBlock) {
        _didFinishAppealBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
