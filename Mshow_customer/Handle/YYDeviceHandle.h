//
//  YYDeviceHandle.h
//  DDFood
//
//  Created by YZ Y on 16/12/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDeviceHandle : NSObject
+ (NSString *)iphoneType;
+ (NSString *)getUUID;
+ (BOOL)makeCall:(NSString *)phoneNumber;

@end
