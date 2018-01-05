//
//  YYAllQuestionViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYAllQuestionViewController.h"
#import "YYQuestionChildViewController.h"

@interface YYAllQuestionViewController ()

@end

@implementation YYAllQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有问题";
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

- (void)setUpAllViewController
{
    YYQuestionChildViewController *buyQuestionVC = [[YYQuestionChildViewController alloc] init];
    buyQuestionVC.title = @"购物指南";
    buyQuestionVC.questionType = YYQuestionTypeBuy;
    [self addChildViewController:buyQuestionVC];
    
    YYQuestionChildViewController *deliveryQuestionVC = [[YYQuestionChildViewController alloc] init];
    deliveryQuestionVC.title = @"配送服务";
    deliveryQuestionVC.questionType = YYQuestionTypeDelivery;
    [self addChildViewController:deliveryQuestionVC];
    
    YYQuestionChildViewController *customerQuesionVC = [[YYQuestionChildViewController alloc] init];
    customerQuesionVC.title = @"售后问题";
    customerQuesionVC.questionType = YYQuestionTypeCustomerService;
    [self addChildViewController:customerQuesionVC];
    
    YYQuestionChildViewController *otherQuestionVC = [[YYQuestionChildViewController alloc] init];
    otherQuestionVC.title = @"其他问题";
    otherQuestionVC.questionType = YYQuestionTypeOther;
    [self addChildViewController:otherQuestionVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
