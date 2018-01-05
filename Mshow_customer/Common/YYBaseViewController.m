//
//  YYBaseViewController.m
//  Service1.0
//
//  Created by YZ Y on 16/4/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYBaseViewController.h"
#import "YYHttpHandle.h"
#import "YYNavigationController.h"
#import "YYGoodsDetailViewController.h"
#import "YYShopDetailViewController.h"
#import "YYSearchViewController.h"

#import "YYSelectViewController.h"
#import "YYHomeGoodsSelectViewController.h"
#import "YYLoginViewController.h"

#import "YYUserModel.h"

@interface YYBaseViewController () 

@end

@implementation YYBaseViewController

{
    UIImageView *_naviLine;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = mRGBColor(240, 240, 240);
//    self.view.backgroundColor = [UIColor whiteColor];
    
    /**设置分割线颜色*/
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:mRGBToColor(0xf0f0f0) size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    _naviLine = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
}

/**找到导航栏的下划线*/
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self isKindOfClass:[YYSearchViewController class]] ||
        [self isKindOfClass:[YYHomeGoodsSelectViewController class]]||
        [self isKindOfClass:[YYSelectViewController class]] || [self isKindOfClass:[YYLoginViewController class]]) {
        //隐藏下划线
        _naviLine.hidden = YES;
    }
    
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ([self isKindOfClass:[YYSearchViewController class]] ||
        [self isKindOfClass:[YYHomeGoodsSelectViewController class]]||
        [self isKindOfClass:[YYSelectViewController class]] ||
        [self isKindOfClass:[YYLoginViewController class]]) {
        //显示下划线
        _naviLine.hidden = NO;
    }
    
}


- (void)setUpLeftItem:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image  highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:title selectedTitle:selectedTitle image:image highImage:highImage target:target action:action];
}

- (void)setUpRightItem:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:title selectedTitle:selectedTitle image:image highImage:highImage target:target action:action];
}

- (void)setUpRightItems:(NSArray *)items
{
    self.navigationItem.rightBarButtonItems = items;
}

- (void)tasksNeedCancelWhenDealloc:(NSArray *)taskArray
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:(mAppDelegate).taskArray];
    [array addObjectsFromArray:taskArray];
    (mAppDelegate).taskArray = [NSArray arrayWithArray:array];
}
#pragma mark - 见面跳转
#pragma mark - 商品详情
- (void)showGoodsDetail:(NSString *)goods_id
{
    YYGoodsDetailViewController *goodsDetailVC = [YYGoodsDetailViewController new];
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}

#pragma mark - 店铺详情
- (void)showShopDetail:(NSString *)shop_id
{
    YYShopDetailViewController *shopDetailVC = [YYShopDetailViewController new];
    [self.navigationController pushViewController:shopDetailVC animated:YES];
}

#pragma mark - 搜索
- (void)showSearchViewController
{
    YYSearchViewController *searchVC = [YYSearchViewController new];
    YYNavigationController *navi = [[YYNavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:navi animated:YES completion:nil];
}
#pragma mark - 显示信息
- (void)showMessage:(NSString *)message hud:(MBProgressHUD *)hud duration:(NSTimeInterval)duration
{
    if (hud) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = [NSString stringWithFormat:@"%@", message];
        [hud hide:YES afterDelay:duration];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = [NSString stringWithFormat:@"%@", message];
        [hud hide:YES afterDelay:duration];
    }
    
}

#pragma mark - 转圈
- (MBProgressHUD *)showHudProgress
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    return hud;
}
#pragma mark - 登录
- (void)executeLogin:(void (^)(YYUserModel *))loginSuccessBlock
{
    YYLoginViewController *loginVC = [[YYLoginViewController alloc] init];
    loginVC.loginSuccessBlock = ^(YYUserModel *userModel) {
        loginSuccessBlock(userModel);
    };
    YYNavigationController *navi = [[YYNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navi animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
