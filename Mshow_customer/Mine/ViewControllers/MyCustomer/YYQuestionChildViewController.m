//
//  YYQuestionChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYQuestionChildViewController.h"
#import "YYQuestionView.h"

@interface YYQuestionChildViewController () <YYQuestionViewDelegate>
@property (nonatomic, weak) YYQuestionView *questionView;

@end

@implementation YYQuestionChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYQuestionView *view = [[YYQuestionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _questionView = view;
    [self fetchData];
}

- (void)setQuestionType:(YYQuestionType)questionType
{
    _questionType = questionType;
    
}

- (void)fetchData
{
    self.questionView.dataArray = @[@"商品咨询", @"购物结算", @"支付"];
}

#pragma mark - YYQuestionViewDelegate
- (void)executeShowQuestion:(NSString *)questionID
{
    MJExtensionLog(@"question:%@", questionID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
