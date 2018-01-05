//
//  YYCheckInstalledAPPHandle.m
//  Fastbike
//
//  Created by YZ Y on 2017/8/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCheckInstalledAPPHandle.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation YYCheckInstalledAPPHandle
+ (BOOL)executeCheckQQ
{
    return [QQApiInterface isQQInstalled];
}

+ (BOOL)executeCheckWeChate
{
    return [WXApi isWXAppInstalled];
}
@end
