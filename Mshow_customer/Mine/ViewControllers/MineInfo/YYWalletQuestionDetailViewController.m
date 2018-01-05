//
//  YYWalletQuestionDetailViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/21.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWalletQuestionDetailViewController.h"
#import "YYWalletQuestionDetailView.h"
#import "YYQuestionModel.h"

@interface YYWalletQuestionDetailViewController ()
@property (nonatomic, weak) YYWalletQuestionDetailView *detailView;

@end

@implementation YYWalletQuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题详情";
    self.view.backgroundColor = [UIColor whiteColor];
    YYWalletQuestionDetailView *detailView = [[YYWalletQuestionDetailView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    detailView.questionModel = _questionModel;
    [self.view addSubview:detailView];
    _detailView = detailView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
