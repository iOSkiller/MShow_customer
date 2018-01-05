//
//  YYWashServiceViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWashServiceViewController.h"
#import "YYWashServiceChildViewController.h"

@interface YYWashServiceViewController ()

@end

@implementation YYWashServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"清洗服务";
    [self createUI];
}

- (void)createUI
{
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
    
    [self setUpAllViewController];
}

- (void)setUpAllViewController
{
    YYWashServiceChildViewController *washCoatVC = [YYWashServiceChildViewController new];
    washCoatVC.title = @"洗衣";
    washCoatVC.type = YYWashServiceTypeCoat;
    [self addChildViewController:washCoatVC];
    
    YYWashServiceChildViewController *washBedVC = [YYWashServiceChildViewController new];
    washBedVC.title = @"洗床品";
    washBedVC.type = YYWashServiceTypeBed;
    [self addChildViewController:washBedVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
