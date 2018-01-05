//
//  YYMemoryCacheHandle.h
//  DDFood
//
//  Created by YZ Y on 17/1/9.
//  Copyright © 2017年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYMemoryCacheHandle : NSObject
/**内存溢出*/
+ (void)clearMemoryWarn;
/**清除图片缓存*/
+ (void)cleanImageCache:(NSString *)url;
/**清除web缓存*/
+ (void)cleanWebCache;
/**获取缓存大小*/
+ (float)getCacheSize;
/**清除缓存*/
+ (void)clearMemoryCache;

@end
