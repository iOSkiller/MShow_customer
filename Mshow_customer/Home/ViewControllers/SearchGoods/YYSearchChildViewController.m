//
//  YYSearchChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchChildViewController.h"
#import "YYSearchView.h"
#import "YYSelectViewController.h"

@interface YYSearchChildViewController () <YYSearchViewDelegate>
@property (nonatomic, weak) YYSearchView *searchView;

@end

@implementation YYSearchChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYSearchView *searchView = [[YYSearchView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    searchView.delegate = self;
    [self.view addSubview:searchView];
    _searchView = searchView;
}

- (void)setText:(NSString *)text
{
    self.searchView.isSearching = [text isValid];
}

#pragma mark - YYSearchViewDelegate
- (void)executeDidSelectSearchResult:(YYSearchModel *)searchModel
{
    YYSelectViewController *selectVC = [[YYSelectViewController alloc] init];
    selectVC.hideToobBar = YES;
    [self.navigationController pushViewController:selectVC animated:YES];
}

- (void)executeDeleteSearchHistory
{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清楚搜索历史" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WS(weakSelf);
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.searchView deleteSearchHistory];
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:sureAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
