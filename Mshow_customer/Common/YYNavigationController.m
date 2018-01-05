//
//  YYNavigationController.m
//  Service1.0
//
//  Created by YZ Y on 16/4/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYNavigationController.h"

@interface YYNavigationController () <UINavigationControllerDelegate>

@end

@implementation YYNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    //修改导航栏颜色
    [bar setBarTintColor:[UIColor whiteColor]];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RELATIVE_WIDTH(36)], NSForegroundColorAttributeName:YYTextColor}];
    bar.translucent = NO;
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    YYNavigationController *nvc = [super initWithRootViewController:rootViewController];
    nvc.delegate = self;
    return nvc;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        [viewController setHidesBottomBarWhenPushed:YES];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_arrow_left"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"img_arrow_left"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.bounds = (CGRect){CGPointZero,[button imageForState:UIControlStateNormal].size};
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = item;
        
    }
    //必须在判断是否有子视图控制的下面
    [super pushViewController:viewController animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:YES];
}

#pragma mark - 返回按钮的点击事件
- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
