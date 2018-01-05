//
//  YYMyCouponChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyCouponChildViewController.h"
#import "YYMyCouponView.h"

@interface YYMyCouponChildViewController ()
@property (nonatomic, weak) YYMyCouponView *couponView;

@end

@implementation YYMyCouponChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YYSeparatorColor;
    YYMyCouponView *view = [[YYMyCouponView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(80))];
    [self.view addSubview:view];
    _couponView = view;
    
    WS(ws);
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(ws.view.safeAreaInsets);
        } else {
            make.edges.equalTo(ws.view);
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.couponView.viewType = _type;
    self.couponView.dataArray = @[];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
