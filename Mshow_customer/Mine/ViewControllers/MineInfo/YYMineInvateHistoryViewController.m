//
//  YYMineInvateHistoryViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateHistoryViewController.h"
#import "YYMineInvateHistoryView.h"
#import "YYInvateHistoryModel.h"

@interface YYMineInvateHistoryViewController ()
@property (nonatomic, weak) YYMineInvateHistoryView *historyView;

@end

@implementation YYMineInvateHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看奖励";
    YYMineInvateHistoryView *historyView = [[YYMineInvateHistoryView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    [self.view addSubview:historyView];
    _historyView = historyView;
    _historyView.dataArray = [YYInvateHistoryModel testDataArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
