//
//  YYUserDefaultHandle.h
//  Fastbike
//
//  Created by YYZ on 2017/12/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYUserDefaultHandle : YYBaseHandle
+ (void)updateUserDefaultInfo:(NSDictionary *)dict;
+ (void)cleanUserDefaultInfo;

@end
