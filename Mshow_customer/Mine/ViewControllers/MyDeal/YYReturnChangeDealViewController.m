//
//  YYReturnChangeDealViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYReturnChangeDealViewController.h"
#import "YYReturnChangeDealView.h"

@interface YYReturnChangeDealViewController ()

@end

@implementation YYReturnChangeDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退货详情";
    self.view.backgroundColor = [UIColor whiteColor];
    YYReturnChangeDealView *view = [[YYReturnChangeDealView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - iPhone_MARGIN_BOTTOM)];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
