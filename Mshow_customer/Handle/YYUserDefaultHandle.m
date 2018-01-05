//
//  YYUserDefaultHandle.m
//  Fastbike
//
//  Created by YYZ on 2017/12/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYUserDefaultHandle.h"

@implementation YYUserDefaultHandle
+ (void)updateUserDefaultInfo:(NSDictionary *)dict
{
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mUserDefaults setObject:[NSString stringWithFormat:@"%@", obj] forKey:key];
    }];
    [mUserDefaults setBool:YES forKey:@"autoLogin"];
    [mUserDefaults synchronize];
}

+ (void)cleanUserDefaultInfo
{
    [mUserDefaults setBool:NO forKey:@"autoLogin"];
    [mUserDefaults removeObjectForKey:@"userId"];
    [mUserDefaults removeObjectForKey:@"userMobile"];
    [mUserDefaults removeObjectForKey:@"userName"];
    [mUserDefaults removeObjectForKey:@"token"];
    [mUserDefaults synchronize];
}

@end
