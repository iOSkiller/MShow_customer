//
//  YYMineCreditRateViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCreditRateViewController.h"
#import "YYMineCreditRateView.h"

@interface YYMineCreditRateViewController ()
@property (nonatomic, weak) YYMineCreditRateView *creditView;

@end

@implementation YYMineCreditRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用评分";
    YYMineCreditRateView *view = [[YYMineCreditRateView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    [self.view addSubview:view];
    _creditView = view;
    _creditView.infoArray = @[@"    1.文明规范穿衣，按时归还商品",
                              @"    2.实名认证",
                              @"    3.保持试穿全新件商标完整"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
