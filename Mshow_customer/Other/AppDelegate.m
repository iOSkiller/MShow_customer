//
//  AppDelegate.m
//  Mshow_customer
//
//  Created by YYZ on 2017/9/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "AppDelegate.h"
#import "YYTabBarController.h"

//引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WeiboSDK.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
#import "YYWeixinPayManager.h"
//支付宝
#import <AlipaySDK/AlipaySDK.h>
#import "AliPayNeedDEF.h"

#import "YYTabBarController.h"
//需要IQBar
#import "YYMineAddressEditeViewController.h"
#import "YYMineCertifyViewController.h"
#import "YYLoginViewController.h"
#import "YYRegisterViewController.h"


#define JPushKey @"449bce93a31f9b3e959f44ac"

@interface AppDelegate () <WXApiDelegate, JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[YYTabBarController alloc] init];
    [_window makeKeyAndVisible];
    (mAppDelegate).iPhoneX = kDevice_Is_iPhoneX;
//    (mAppDelegate).isLogin = [mUserDefaults boolForKey:@"autoLogin"];
    (mAppDelegate).isLogin = YES;
    (mAppDelegate).userID = [mUserDefaults objectForKey:@"userId"];
    (mAppDelegate).userName = [mUserDefaults objectForKey:@"userName"];
    (mAppDelegate).userMobile = [mUserDefaults objectForKey:@"userMobile"];
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"3929793843"
                                           appSecret:@"6a81f5e92b8372eb65962386b1dc7246"
                                         redirectUri:@"https://www.u10w.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx7fcf7cf059e5320f"
                                       appSecret:@"6c340cb0405f473ba501839c75f4e368"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105612181"
                                      appKey:@"bqrfTjh0mkKTKVfP"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
         
     }
     ];
    
    
    //设置键盘
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //修改toolbar上的完成按钮文字
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    //工具栏字体颜色
    [IQKeyboardManager sharedManager].toolbarTintColor = mRGBToColor(0x0777ff);
    //隐藏键盘和上面的占位提示框之间的一点间距
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:0];
    
    //隐藏toolbar上的placeholder文字
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //开启指定控制器中键盘的toolbar
    NSArray *enableClassesArray = @[[YYMineAddressEditeViewController class],
                                    [YYMineCertifyViewController class],
                                    [YYLoginViewController class],
                                    [YYRegisterViewController class]];
    [[[IQKeyboardManager sharedManager] enabledToolbarClasses] addObjectsFromArray:enableClassesArray];
    
    //注册本地推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) { // iOS8
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:setting];
    }
    
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 这里添加处理代码
        //        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:YYReceiveNotification object:nil userInfo:aps];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    //初始化APNs
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 10.0, *)) {
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        } else {
            // Fallback on earlier versions
        }
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        if (@available(iOS 10.0, *)) {
            [JPUSHService registerForRemoteNotificationTypes:(UNAuthorizationOptionBadge |
                                                              UNAuthorizationOptionSound |
                                                              UNAuthorizationOptionAlert)
                                                  categories:nil];
        } else {
            // Fallback on earlier versions
        }
    }
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];

    //进入APP清空服务器上的角标数量
    [JPUSHService resetBadge];
    
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            NSLog(@"推送消息==== %@",remoteNotification);
            [[NSNotificationCenter defaultCenter] postNotificationName:YYReceiveNotification object:nil userInfo:remoteNotification];
        }
    }
    
    //接收本地推送
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        NSLog(@"%@",launchOptions);
        
    }
    
    return YES;
}

// 进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

#pragma mark - 支付宝微信支付相关代理
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqual:@"9000"]) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_FAILED];
            }
        }];
        
        
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    } else if ([url.host isEqualToString:@"platformapi"]) {//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqual:@"9000"]) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_FAILED];
            }
        }];
    }
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    if ([[NSString stringWithFormat:@"%@",url] rangeOfString:[NSString stringWithFormat:@"%@://pay", APP_ID]].location != NSNotFound) {
        return  [WXApi handleOpenURL:url delegate:self];
        //不是上面的情况的话，就正常用shareSDK调起相应的分享页面
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqual:@"9000"]) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_FAILED];
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length > 0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    } else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqual:@"9000"]) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_FAILED];
            }
        }];
    }
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    if ([[NSString stringWithFormat:@"%@",url] rangeOfString:[NSString stringWithFormat:@"%@://pay", APP_ID]].location != NSNotFound) {
        return  [WXApi handleOpenURL:url delegate:self];
        //不是上面的情况的话，就正常用shareSDK调起相应的分享页面
    }
    return YES;
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法
- (void)onResp:(BaseResp *)resp
{
    //这里判断回调信息是否为 支付
//    if([resp isKindOfClass:[PayReq class]]){
//        switch (resp.errCode) {
//            case WXSuccess:
//                //如果支付成功的话，全局发送一个通知，支付成功
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"weixin_pay_result" object:IS_SUCCESSED];
//                break;
//
//            default:
//                //如果支付失败的话，全局发送一个通知，支付失败
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"weixin_pay_result" object:IS_FAILED];
//                break;
//        }
//    }
    switch (resp.errCode) {
        case WXSuccess:
            //如果支付成功的话，全局发送一个通知，支付成功
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weixin_pay_result" object:IS_SUCCESSED];
            break;
            
        default:
            //如果支付失败的话，全局发送一个通知，支付失败
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weixin_pay_result" object:IS_FAILED];
            break;
    }
}

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


//ios10.0以下 获取推送内容
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    //    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    //    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    //    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    //获取推送详情
    [[NSNotificationCenter defaultCenter] postNotificationName:YYReceiveNotification object:nil userInfo:aps];
    
    // 取得Extras字段内容
    //    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    //    NSLog(@"content = [%@], badge = [%@], sound = [%@], customize field = [%@]", content, @(badge), sound, customizeField1);
    
    // iOS 10 以下 Required
    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
    [JPUSHService handleRemoteNotification:userInfo];
    
}

//获取本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [notification valueForKey:@"aps"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YYReceiveNotification object:nil userInfo:aps];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YYReceiveNotification object:nil userInfo:aps];
    
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        } else {
            // 本地通知 response.notification
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:YYReceiveNotification object:nil userInfo:userInfo];
        } else {
            // 本地通知 response.notification
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
