//
//  YYDealViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealViewController.h"
#import "YYDealChildViewController.h"

@interface YYDealViewController ()

@end

@implementation YYDealViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的订单";
    self.isfullScreen = NO;
    self.scrollEnable = NO;
    //设置选项属性
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = YYTextColor;
        *selColor = mRGBToColor(0xf46060);
        *titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        *titleHeight = RELATIVE_WIDTH(80);
    }];
    
    //设置下划线
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *isUnderLineDelayScroll = NO;
        *isUnderLineEqualTitleWidth = YES;
        *underLineH = RELATIVE_WIDTH(2);
        *underLineColor = YYGlobalColor;
    }];
    
    [self setUpAllViewController];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)setUpAllViewController
{
    YYDealChildViewController *allDealVC = [[YYDealChildViewController alloc] init];
    allDealVC.title = @"全部";
    allDealVC.statusType = YYDealStatusTypeAll;
    [self addChildViewController:allDealVC];
    
    YYDealChildViewController *waitForPayVC = [[YYDealChildViewController alloc] init];
    waitForPayVC.title = @"待付款";
    waitForPayVC.statusType = YYDealStatusTypeWaitForPay;
    [self addChildViewController:waitForPayVC];
    
    YYDealChildViewController *waitforSendVC = [[YYDealChildViewController alloc] init];
    waitforSendVC.title = @"待发货";
    waitforSendVC.statusType = YYDealStatusTypeWaitForDelivery;
    [self addChildViewController:waitforSendVC];
    
    YYDealChildViewController *waitForRecieveVC = [[YYDealChildViewController alloc] init];
    waitForRecieveVC.title = @"待收货";
    waitForRecieveVC.statusType = YYDealStatusTypeWaitForRecieve;
    [self addChildViewController:waitForRecieveVC];
    
    YYDealChildViewController *waitForReturnVC = [[YYDealChildViewController alloc] init];
    waitForReturnVC.title = @"待归还";
    waitForReturnVC.statusType = YYDealStatusTypeWaitForReturn;
    [self addChildViewController:waitForReturnVC];
    
    YYDealChildViewController *waitForCommentVC = [[YYDealChildViewController alloc] init];
    waitForCommentVC.title = @"待评论";
    waitForCommentVC.statusType = YYDealStatusTypeWaitForComment;
    [self addChildViewController:waitForCommentVC];
    
    YYDealChildViewController *waitForSubmitVC = [[YYDealChildViewController alloc] init];
    waitForSubmitVC.title = @"待确认";
    waitForSubmitVC.statusType = YYDealStatusTypeWaitForSubmit;
    [self addChildViewController:waitForSubmitVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
