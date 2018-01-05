//
//  YYHttpHandle.m
//  DDFood
//
//  Created by YZ Y on 16/6/4.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#define TimeOutInterval 15.0f

#define SSLCertificate @"u10w.com"

#import "YYHttpHandle.h"
#import <AFNetworking.h>
#import "YYHttpResopseErrorCode.h"


@implementation YYHttpHandle
+ (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    __weak AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = TimeOutInterval;
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *task =
    [manager                        GET:url
                             parameters:params
                               progress:^(NSProgress * _Nonnull downloadProgress) {
                                   
                               }
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                                    if (result) {
                                        success(result);
                                    } else {
                                        !success ? : success(responseObject);
                                    }
                                    
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    if (failure) {
                                        NSInteger statusCode = getErrorStatusCode(task);
                                        
                                        NSInteger errorCode = getErrorCode(error);
                                    
                                        failure((int)statusCode, (int)errorCode);
                                    }
                                }
     ];
    return task;
}

+ (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    __weak AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = TimeOutInterval;
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //https ssl证书认证
//    [manager setSecurityPolicy:[self customSecurityPolicy]];

    
    NSURLSessionDataTask *task =
    [manager                        POST:url
                              parameters:params
                                progress:^(NSProgress * _Nonnull uploadProgress) {
                                    
                                }
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                                     if (result) {
                                         success(result);
                                     } else {
                                         !success ? : success(responseObject);
                                     }
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     if (failure) {
                                         NSInteger statusCode = getErrorStatusCode(task);
                                         NSInteger errorCode = getErrorCode(error);
                                         failure((int)statusCode, (int)errorCode);
                                     }
                                 }
     ];
    return task;
}


+ (AFSecurityPolicy *)customSecurityPolicy {
    //先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:SSLCertificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。沃通证书需要设置成NO
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    return securityPolicy;
}

//数据提交及图片上传(post类型)
+ (void)requestWithUploadPictureWithUrl:(NSString *)URLString params:(NSDictionary *)params name:(NSString *)name imageData:(NSData *)imageData successBlock:(HTTPRequestV2SuccessBlock)successReqBlock failedBlock:(HTTPRequestV2FailedBlock)failedReqBlock
{
    if (!(mAppDelegate).haveNetwork) {
        return;
    }
    //获取上传图片的时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
    NSString *fileName = [formatter stringFromDate:[NSDate date]];
    
    if (IOS_VERSION >= 8.0) {
        __weak AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = TimeOutInterval;
        [manager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"png/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (successReqBlock) {
                successReqBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failedReqBlock) {
                failedReqBlock(error);
            }
        }];
    } else {
        NSURL *fileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:fileName]];
        NSMutableURLRequest *multipartRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"jpg/png"];
        } error:nil];
        [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:multipartRequest writingStreamContentsToFile:fileUrl completionHandler:^(NSError * _Nullable error) {
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer.timeoutInterval = TimeOutInterval;
            NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:multipartRequest fromFile:fileUrl progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                [[NSFileManager defaultManager] removeItemAtURL:fileUrl error:nil];
                if (error) {
                    failedReqBlock(error);
                } else {
                    successReqBlock(responseObject);
                }
            }];
            [uploadTask resume];
        }];
    }
}

+ (void)checkNetWorkStatus:(NekworkStatus)nekworkStatus
{
    //网络监控
    __weak AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                nekworkStatus(@"未知网络状态");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                nekworkStatus(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                nekworkStatus(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                nekworkStatus(@"WiFi网络");
                
                break;
                
        };
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            (mAppDelegate).haveNetwork = YES;
        } else {
            (mAppDelegate).haveNetwork = NO;
        }
    }];
}


+ (void)cancelAllRequest
{
    __weak AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

+ (void)cancelSingleTask:(NSString *)key
{
    for (NSDictionary *dic in (mAppDelegate).taskArray) {
        if ([dic[@"key"] isEqualToString:key]) {
            NSURLSessionDataTask *task = dic[@"task"];
            if (task.state == NSURLSessionTaskStateRunning) {
                [task cancel];
            }
        }
    }
}

@end
