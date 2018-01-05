//
//  YYCommentSuccessViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/21.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentSuccessViewController.h"
#import "YYDealViewController.h"
#import "YYMyCommentViewController.h"
#import "YYGoodsDetailViewController.h"

#import "YYCommentSuccessView.h"
#import "YYGoodsModel.h"

@interface YYCommentSuccessViewController () <YYCommentSuccessViewDelegate>
@property (nonatomic, weak) YYCommentSuccessView *successView;

@end

@implementation YYCommentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价成功";
    self.fd_interactivePopDisabled = YES;
    [self setUpLeftItem:nil selectedTitle:nil image:@"img_arrow_left" highImage:@"img_arrow_left" target:self action:@selector(backAction)];
    YYCommentSuccessView *view = [[YYCommentSuccessView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    view.likeArray = [YYGoodsModel testWomanArray];
    [self.view addSubview:view];
    _successView = view;
}

- (void)backAction
{
    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[YYDealViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

#pragma mark - YYCommentSuccessViewDelegate
- (void)executeShowGoods:(YYGoodsModel *)goodsModel
{
    [self.navigationController pushViewController:[YYGoodsDetailViewController new] animated:YES];
}

- (void)executeShowMyComment
{
    [self.navigationController pushViewController:[YYMyCommentViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
