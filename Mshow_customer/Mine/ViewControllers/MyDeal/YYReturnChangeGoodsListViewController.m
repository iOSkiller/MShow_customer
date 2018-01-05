//
//  YYReturnChangeGoodsListViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2018/1/3.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import "YYReturnChangeGoodsListViewController.h"
#import "YYReturnChangeGoodsListView.h"
#import "YYReturnChangeDealViewController.h"
#import "YYDealModel.h"

@interface YYReturnChangeGoodsListViewController () <YYReturnChangeGoodsListViewDelegate>
@property (nonatomic, weak) YYReturnChangeGoodsListView *listView;

@end

@implementation YYReturnChangeGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退货/售后";
    self.view.backgroundColor = [UIColor whiteColor];
    YYReturnChangeGoodsListView *listView = [[YYReturnChangeGoodsListView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    listView.delegate = self;
    [self.view addSubview:listView];
    _listView = listView;
    _listView.dealArray = [YYDealModel testTryDataArray];
}

#pragma mark - YYReturnChangeGoodsListViewDelegate
- (void)executeShowDealDetail:(YYDealModel *)dealModel
{
    YYReturnChangeDealViewController *dealVC = [YYReturnChangeDealViewController new];
    [self.navigationController pushViewController:dealVC animated:YES];
}

- (void)executeLoadMoreData
{
    _listView.dealArray = [YYDealModel testTryDataArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
