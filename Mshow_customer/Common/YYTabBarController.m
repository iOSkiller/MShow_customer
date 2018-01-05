//
//  YYTabBarController.m
//  Service1.0
//
//  Created by YZ Y on 16/4/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYTabBarController.h"
#import "YYNavigationController.h"


//不需要导航栏
#import "YYHomeViewController.h"
#import "YYShoppingCartViewController.h"
#import "YYMineViewController.h"
#import "YYSelectViewController.h"
#import "YYShowViewController.h"


@interface YYTabBarController () <UINavigationControllerDelegate, UITabBarControllerDelegate>

@end

@implementation YYTabBarController

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RELATIVE_WIDTH(22)], NSForegroundColorAttributeName:mRGBToColor(0xa4a4a4)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RELATIVE_WIDTH(22)], NSForegroundColorAttributeName:YYGlobalColor} forState:UIControlStateSelected];
    //设置title的位置是左右偏移(horizontal) 还是上下偏移(vertical)
    [item setTitlePositionAdjustment:UIOffsetMake(0, -2.5)];
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_light"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewControllers];
    self.delegate = self;
    [self.tabBar setClipsToBounds:YES];
}

- (void)setUpChildViewControllers
{
    YYHomeViewController *homeVC = [[YYHomeViewController alloc] init];
    [self setUpOneViewController:homeVC title:@"首页" image:@"tab_icon_home_n" selectedImage:@"tab_icon_home_pre"];
    YYSelectViewController *selectVC = [[YYSelectViewController alloc] init];
    [self setUpOneViewController:selectVC title:@"选衣" image:@"tab_icon_Choose_n" selectedImage:@"tab_icon_Choose_pre"];
    YYShowViewController *showVC = [[YYShowViewController alloc] init];
    YYShoppingcartViewController *cartVC = [[YYShoppingcartViewController alloc] init];
    [self setUpOneViewController:showVC title:@"秀一秀" image:@"tab_icon_show_n" selectedImage:@"tab_icon_show_pre"];
    [self setUpOneViewController:cartVC title:@"衣橱" image:@"tab_icon_wardrobe_n" selectedImage:@"tab_icon_wardrobe_pre"];
    YYMineViewController *mineVC = [[YYMineViewController alloc] init];
    [self setUpOneViewController:mineVC title:@"我的" image:@"tab_icon_mine_n" selectedImage:@"tab_icon_mine_pre"];
    
    
}

- (void)setUpOneViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    YYNavigationController *navi = [[YYNavigationController alloc] initWithRootViewController:viewController];
    navi.delegate = self;
    [self addChildViewController:navi];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
