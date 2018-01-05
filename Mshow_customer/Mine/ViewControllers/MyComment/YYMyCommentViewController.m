//
//  YYMyCommentViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyCommentViewController.h"
#import "YYMineCommentView.h"
#import "YYCommentModel.h"

@interface YYMyCommentViewController () <YYMineCommentViewDelegate>
@property (nonatomic, weak) YYMineCommentView *commentView;

@end

@implementation YYMyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评价";
    YYMineCommentView *commentView = [[YYMineCommentView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    [self.view addSubview:commentView];
    _commentView = commentView;
    self.commentView.dataArray = [YYCommentModel testNormalDataArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - YYMineCommentViewDelegate
- (void)executeEditeComment:(YYCommentModel *)commentModel
{
    
}

- (void)executeShowComments:(YYCommentModel *)commentModel
{
    
}

@end
