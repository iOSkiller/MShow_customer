//
//  YYMyWardrobeViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyWardrobeViewController.h"
#import "YYMyWardrobeChildViewController.h"

@interface YYMyWardrobeViewController ()

@end

@implementation YYMyWardrobeViewController

{
    UIImageView *_line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的衣橱";
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _line.hidden = NO;
}

- (void)setUpAllViewController
{
    YYMyWardrobeChildViewController *payedVC = [[YYMyWardrobeChildViewController alloc] init];
    payedVC.title = @"已购买";
    payedVC.viewType = YYMineWardrobeViewTypePayed;
    [self addChildViewController:payedVC];
    
    YYMyWardrobeChildViewController *testedVC = [[YYMyWardrobeChildViewController alloc] init];
    testedVC.title = @"已试穿";
    testedVC.viewType = YYMineWardrobeViewTypeTried;
    [self addChildViewController:testedVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
