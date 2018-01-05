//
//  YYBaseViewController.h
//  Service1.0
//
//  Created by YZ Y on 16/4/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYUserModel;

@interface YYBaseViewController : UIViewController
/**导航栏左侧按钮*/
- (void)setUpLeftItem:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
/**导航右侧按钮*/
- (void)setUpRightItem:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
- (void)setUpRightItems:(NSArray *)items;
/**添加在dealloc时需要取消的task*/
- (void)tasksNeedCancelWhenDealloc:(NSArray *)taskArray;
/**导航栏下划线*/
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;
/**跳转商品详情页*/
- (void)showGoodsDetail:(NSString *)goods_id;
/**跳转店铺详情页*/
- (void)showShopDetail:(NSString *)shop_id;
/**跳转搜索*/
- (void)showSearchViewController;
/**提示信息*/
- (void)showMessage:(NSString *)message hud:(MBProgressHUD *)hud duration:(NSTimeInterval)duration;
/**转圈*/
- (MBProgressHUD *)showHudProgress;
/**登录*/
- (void)executeLogin:(void (^) (YYUserModel *userModel))loginSuccessBlock;

@end
