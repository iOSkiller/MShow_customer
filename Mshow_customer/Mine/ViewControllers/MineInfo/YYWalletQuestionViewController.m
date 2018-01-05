//
//  YYWalletQuestionViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/12.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWalletQuestionViewController.h"
#import "YYWalletQuestionView.h"
#import "YYQuestionModel.h"
#import "YYWalletQuestionDetailViewController.h"

@interface YYWalletQuestionViewController ()
@property (nonatomic, weak) YYWalletQuestionView *questionView;

@end

@implementation YYWalletQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    YYWalletQuestionView *view = [[YYWalletQuestionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    WS(weakSelf);
    view.showQuestionDetailBlock = ^(YYWalletQuestionType questionType) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        NSArray *array = [YYQuestionModel walletQuestionArray];
        YYWalletQuestionDetailViewController *detailVC = [YYWalletQuestionDetailViewController new];
        detailVC.questionModel = array[questionType];
        [strongSelf.navigationController pushViewController:detailVC animated:YES];
    };
    [self.view addSubview:view];
    _questionView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
