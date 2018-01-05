//
//  AppDelegate.h
//  Mshow_customer
//
//  Created by YYZ on 2017/9/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL haveNetwork;
@property (nonatomic, assign) BOOL iPhoneX;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userMobile;
@property (nonatomic, copy) NSArray *taskArray;
@property (nonatomic, copy) NSString *AESKEY;
@property (nonatomic, copy) NSString *city;

@end

