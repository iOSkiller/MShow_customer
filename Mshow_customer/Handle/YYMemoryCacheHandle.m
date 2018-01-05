//
//  YYMemoryCacheHandle.m
//  DDFood
//
//  Created by YZ Y on 17/1/9.
//  Copyright © 2017年 YZ Y. All rights reserved.
//

#import "YYMemoryCacheHandle.h"

@implementation YYMemoryCacheHandle
+ (void)clearMemoryWarn
{
    // 停止下载图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 清除内存缓存图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

+ (void)cleanImageCache:(NSString *)url
{
    [[SDImageCache sharedImageCache] removeImageForKey:url fromDisk:YES withCompletion:nil];
}

+ (float)getCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath: cachePath]) return 0 ;
    //由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
    ////获取文件全路径
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachePath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    // 遍历文件夹获得文件夹大小，返回多少 M
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        // 计算 单个文件的大小
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent: fileName];
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath :fileAbsolutePath]){
            folderSize += [[manager attributesOfItemAtPath:fileAbsolutePath error : nil] fileSize];
        }
    }
    return folderSize/( 1024.0 * 1024.0);
}

+ (void)cleanWebCache
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

+ (void)clearMemoryCache
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
}

@end
