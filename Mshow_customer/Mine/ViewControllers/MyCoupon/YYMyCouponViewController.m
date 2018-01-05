//
//  YYMyCouponViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyCouponViewController.h"
#import "YYMyCouponChildViewController.h"

@interface YYMyCouponViewController ()

@end

@implementation YYMyCouponViewController

{
    UIImageView *_line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"优惠券";
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
    
    _line = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    _line.backgroundColor = mRGBToColor(0xf0f0f0);
    [self setUpAllViewController];
}

- (void)setUpAllViewController
{
    YYMyCouponChildViewController *noUseVC = [[YYMyCouponChildViewController alloc] init];
    noUseVC.title = @"未使用";
    noUseVC.type = YYCouponTypeAvailable;
    [self addChildViewController:noUseVC];
    
    YYMyCouponChildViewController *didUseVC = [[YYMyCouponChildViewController alloc] init];
    didUseVC.title = @"已使用";
    didUseVC.type = YYCouponTypeUsed;
    [self addChildViewController:didUseVC];
    
    YYMyCouponChildViewController *unUseVC = [[YYMyCouponChildViewController alloc] init];
    unUseVC.title = @"已过期";
    unUseVC.type = YYCouponTypeDisable;
    [self addChildViewController:unUseVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
