//
//  YYWithDrawCashViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWithDrawCashViewController.h"
#import "YYWithDrawCashView.h"

@interface YYWithDrawCashViewController () <YYWithDrawCashViewDelegate>
@property (nonatomic, weak) YYWithDrawCashView *withDrawView;

@end

@implementation YYWithDrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额提现";
    YYWithDrawCashView *drawView = [[YYWithDrawCashView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    drawView.delegate = self;
    [self.view addSubview:drawView];
    _withDrawView = drawView;
    WS(ws);
    [self.withDrawView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(ws.view.safeAreaInsets);
        } else {
            make.edges.equalTo(ws.view);
        }
    }];
}

#pragma mark - YYWithDrawCashViewDelegate
- (void)executeWithDrawCash:(NSString *)cashSum type:(YYPayType)type
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
