//
//  YYHomeViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeViewController.h"
#import "YYNavigationView.h"
#import "YYHomeView.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"
#import "YYGoodsDetailViewController.h"
#import "YYHomeGoodsSelectViewController.h"
#import "YYSelectChildViewController.h"
#import "YYShopDetailViewController.h"
#import "YYWashServiceViewController.h"
#import "YYMessageCenterViewController.h"

#import "YYUserModel.h"

#import "YYHomeDateHandle.h"

@interface YYHomeViewController () <YYNavigationViewDelegate, YYHomeViewDelegate>
@property (nonatomic, weak) YYNavigationView *naviView;
@property (nonatomic, weak) YYHomeView *homeView;

@end

@implementation YYHomeViewController

- (YYNavigationView *)naviView {
    if (!_naviView) {
        YYNavigationView *view = [[YYNavigationView alloc] initWithFrame:CGRectMake(0, (mAppDelegate).iPhoneX ? iPhoneX_statusBarHeight : 0, WIN_WIDTH, 64)];
        view.delegate = self;
        view.backgroundColor = [UIColor clearColor];
        view.searchBarHaveCorner = YES;
        [self.view addSubview:view];
        _naviView = view;
    }
    return _naviView;
}

- (YYHomeView *)homeView {
    if (!_homeView) {
        YYHomeView *view = [[YYHomeView alloc] initWithFrame:CGRectMake(0, kDevice_Is_iPhoneX ? 0 : -20, WIN_WIDTH, WIN_HEIGHT - iPhone_Tabbar_Height + ((mAppDelegate).iPhoneX ? iPhoneX_statusBarHeight : 20))];
        view.delegate = self;
        [self.view addSubview:view];
        _homeView = view;
    }
    return _homeView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self naviView];
    [self homeView];
    [self.view insertSubview:self.naviView aboveSubview:self.homeView];

    if ((mAppDelegate).iPhoneX) {
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, iPhoneX_statusBarHeight)];
        statusView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:statusView];
        [self.view insertSubview:statusView aboveSubview:self.homeView];
    }
    
    [self.view insertSubview:self.naviView aboveSubview:self.homeView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [YYHomeDateHandle executeGetBanner:^(id obj) {
        
    } failed:^(id failed) {
        
    }];
}

#pragma mark - YYNavigationViewDelegate
- (void)clickLeftButton
{
    WS(ws);
    [YYHomeDateHandle executeGetBanner:^(id obj) {
        StrongSelf(strongSelf);
        strongSelf = ws;
    } failed:^(id failed) {
        
    }];
}

- (void)clickRightButton:(UIButton *)button
{
    if ((mAppDelegate).isLogin) {
        [self.navigationController pushViewController:[YYMessageCenterViewController new] animated:YES];
    } else {
        [self executeLogin:^(YYUserModel *userModel) {
            [self.navigationController pushViewController:[YYMessageCenterViewController new] animated:YES];
        }];
    }
}

- (void)showSearchView
{
    [self showSearchViewController];
}

#pragma mark - YYHomeViewDelegate
- (void)showAdsDetail:(NSString *)adsID
{
    
}

- (void)homeViewShowMoreInfo:(YYHomeCellType)type
{
    NSString *str = @"";
    
    if (type == YYHomeCellTypeShop) {
        YYSelectChildViewController *shopSelectVC = [YYSelectChildViewController new];
        shopSelectVC.type = YYSelectChildViewTypeShop;
        shopSelectVC.title = @"店铺推荐";
        shopSelectVC.isFullScreen = YES;
        [self.navigationController pushViewController:shopSelectVC animated:YES];
    } else {
        YYHomeGoodsSelectViewController *goodsSelectVC = [YYHomeGoodsSelectViewController new];
        switch (type) {
            case YYHomeCellTypeHot:
                str = @"今日爆品";
                break;
            case YYHomeCellTypeNew:
                str = @"今日新品";
                break;
            case YYHomeCellTypeTried:
                str = @"完美体验";
                break;
            default:
                break;
        }
        goodsSelectVC.title = str;
        [self.navigationController pushViewController:goodsSelectVC animated:YES];
    }
    
    
    MJExtensionLog(@"%@", str);
}

- (void)homeViewDidSelectItem:(YYGoodsModel *)goodsModel index:(NSInteger)index
{
    MJExtensionLog(@"%ld", (long)index);
    YYGoodsDetailViewController *detailVC = [[YYGoodsDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)homeViewDidSelectShop:(YYShopModel *)shopModel
{
    YYShopDetailViewController *shopDetailVC = [YYShopDetailViewController new];
    shopDetailVC.title = shopModel.shopName;
    [self.navigationController pushViewController:shopDetailVC animated:YES];
}

- (void)homeViewShowHomeFunction:(YYHomeFunctionType)functionType
{
    
    if (functionType == YYHomeFunctionTypeWash) {
        YYWashServiceViewController *washVC = [YYWashServiceViewController new];
        [self.navigationController pushViewController:washVC animated:YES];
    } else {
        YYHomeGoodsSelectViewController *goodsSelectVC = [YYHomeGoodsSelectViewController new];
        switch (functionType) {
            case YYHomeFunctionTypeHot:
                goodsSelectVC.dataType = YYSelectChildViewDataTypeHot;
                break;
            case YYHomeFunctionTypeNew:
                goodsSelectVC.dataType = YYSelectChildViewDataTypeNew;
                break;
            case YYHomeFunctionTypeFree:
                goodsSelectVC.dataType = YYSelectChildViewDataTypeTry;
                break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:goodsSelectVC animated:YES];
    }
    
}

- (void)homeViewDidScroll:(CGPoint)contentoffset
{
    if (contentoffset.y - ((mAppDelegate).iPhoneX ? iPhoneX_NaviWithStatusBar : 64) > 0)
    {
        CGFloat alpha = contentoffset.y / 150;
        self.naviView.alpha = alpha > 1 ? 1 : alpha;
        self.naviView.backgroundColor = [UIColor whiteColor];
        self.naviView.hideLine = YES;
    }
    else
    {
        self.naviView.alpha = 1.0;
        self.naviView.backgroundColor = [UIColor clearColor];
    }
    
    self.naviView.hidden = contentoffset.y < ((mAppDelegate).iPhoneX ? - 54 : -30) ;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
