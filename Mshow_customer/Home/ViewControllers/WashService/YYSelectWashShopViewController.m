//
//  YYSelectWashShopViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectWashShopViewController.h"
#import "YYSelectWashShopView.h"
#import "YYShopModel.h"
#import "YYSearchWashShopViewController.h"

@interface YYSelectWashShopViewController () <YYSelectWashShopViewDelegate>
@property (nonatomic, weak) YYSelectWashShopView *selectView;

@end

@implementation YYSelectWashShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择干洗店";
    self.view.backgroundColor = [UIColor whiteColor];
    YYSelectWashShopView *selectView = [[YYSelectWashShopView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    selectView.delegate = self;
    [self.view addSubview:selectView];
    _selectView = selectView;
}

#pragma mark - YYSelectWashShopViewDelegate
- (void)executeDidSelectShop:(YYShopModel *)shopModel
{
    if (_didSelectWashShopBlock) {
        _didSelectWashShopBlock(shopModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)executeSearchWashShop
{
    YYSearchWashShopViewController *searchWashShopVC = [[YYSearchWashShopViewController alloc] init];
    searchWashShopVC.didSelectWashShopBlock = ^(YYShopModel *shopModel) {
        if (_didSelectWashShopBlock) {
            _didSelectWashShopBlock(shopModel);
            WS(weakSelf);
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.navigationController pushViewController:searchWashShopVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
