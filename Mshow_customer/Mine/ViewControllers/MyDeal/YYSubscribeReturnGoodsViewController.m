//
//  YYSubscribeReturnGoodsViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSubscribeReturnGoodsViewController.h"
#import "YYSubscribeReturnGoodsView.h"
#import "YYDealModel.h"
#import "YYSubscribeSuccessViewController.h"

@interface YYSubscribeReturnGoodsViewController () <YYSubscribeReturnGoodsViewDelegate>
@property (nonatomic, weak) YYSubscribeReturnGoodsView *subscribeView;

@end

@implementation YYSubscribeReturnGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _type == YYMineFunctionTypeReturn ? @"下单归还" : @"自还";
    self.view.backgroundColor = [UIColor whiteColor];
    YYSubscribeReturnGoodsView *view = [[YYSubscribeReturnGoodsView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.type = _type;
    view.delegate = self;
    [self.view addSubview:view];
    _subscribeView = view;
}

#pragma mark - YYSubscribeReturnGoodsViewDelegate
- (void)executeSureAction:(YYDealModel *)dealModel
{
    YYSubscribeSuccessViewController *successVC = [YYSubscribeSuccessViewController new];
    successVC.type = _type == YYMineFunctionTypeReturn ? YYSubscribeSuccessViewTypeReturnGoods : YYSubscribeSuccessViewTypeReturnGoodsBySelf;
    [self.navigationController pushViewController:successVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
