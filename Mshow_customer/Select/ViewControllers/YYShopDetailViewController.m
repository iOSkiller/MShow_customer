//
//  YYShopDetailViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopDetailViewController.h"
#import "YYShopDetailView.h"
#import "YYShopModel.h"
#import "YYGoodsModel.h"
#import "YYShopGoodsKindViewController.h"
#import "YYNaviBar.h"
#import "YYShopHandle.h"

@interface YYShopDetailViewController () <YYShopDetailViewDelegate>
@property (nonatomic, weak) YYShopDetailView *detailView;
@property (nonatomic, weak) YYNaviBar *naviBar;

@end

@implementation YYShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SKDJHS旗舰店";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
    [rightButton setImage:[UIImage imageNamed:@"img_follow_n"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"img_follow_pre"] forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    YYShopDetailView *view = [[YYShopDetailView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _detailView = view;
    
//    YYNaviBar *bar = [[YYNaviBar alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, 64)];
//    bar.backgroundColor = [UIColor clearColor];

//    [bar setRightItem:rightButton];
//
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"img_arrow_white_left"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    backButton.frame = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
//    [bar setLeftItem:backButton];
//    [self.view addSubview:bar];
//    _naviBar = bar;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [YYShopHandle executeGetShopInfo:@"1" success:^(id obj) {
        
    } failed:^(id failed) {
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)followAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
}

#pragma mark - YYNavigationViewDelegate
- (void)clickRightButton:(UIButton *)button;
{
    
}

- (void)clickLeftButton;
{
    
}

#pragma mark - YYShopDetailViewDelegate
- (void)executeDidScroll:(CGFloat)contentY
{
    if (contentY > RELATIVE_WIDTH(500)) {
        self.naviBar.backgroundColor = YYSeparatorColor;
    } else {
        self.naviBar.backgroundColor = [UIColor clearColor];
    }
}

- (void)executeShowAllKinds
{
    YYShopGoodsKindViewController *kindVC = [[YYShopGoodsKindViewController alloc] init];
    [self.navigationController pushViewController:kindVC animated:YES];
}

- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)executeFollowGoods:(YYGoodsModel *)goodsModel
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
