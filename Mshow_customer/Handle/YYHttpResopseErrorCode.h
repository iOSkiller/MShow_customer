//
//  YYHttpResopseErrorCode.h
//  DDFood
//
//  Created by YZ Y on 16/6/17.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NSInteger     getErrorStatusCode  (NSURLSessionDataTask *task);

NSInteger     getErrorCode        (NSError *error);

NSDictionary *getError            (NSError *error);