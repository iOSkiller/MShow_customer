//
//  YYHttpResopseErrorCode.m
//  DDFood
//
//  Created by YZ Y on 16/6/17.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYHttpResopseErrorCode.h"

NSInteger getErrorStatusCode (NSURLSessionDataTask *task)
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    return httpResponse.statusCode;
}

NSInteger getErrorCode (NSError *error)
{
    if (error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        NSString *errorCode = responseDict[@"errorCode"];
        return [errorCode integerValue];
    } else {
        return 901;
    }
}

NSDictionary *getError (NSError *error)
{
    if (error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        return responseDict;
    } else {
        return nil;
    }
}
