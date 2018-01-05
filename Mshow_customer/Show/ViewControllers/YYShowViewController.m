//
//  YYShowViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShowViewController.h"
#import "YYShowChildViewController.h"

@interface YYShowViewController ()

@end

@implementation YYShowViewController

{
    UIImageView *_line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"M秀";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"tab_icon_show_n"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
    [rightBtn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    [self setUpAllViewController];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _line.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _line.hidden = NO;
}

- (void)setUpAllViewController
{
    YYShowChildViewController *hotVC = [[YYShowChildViewController alloc] init];
    hotVC.title = @"热门";
    [self addChildViewController:hotVC];
    
    YYShowChildViewController *followVC = [[YYShowChildViewController alloc] init];
    followVC.title = @"关注";
    [self addChildViewController:followVC];
}

- (void)openPhoto
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
