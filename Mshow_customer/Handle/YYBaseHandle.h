//
//  YYBaseHandle.h
//  DDFood
//
//  Created by YZ Y on 16/6/3.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYBaseHandle : NSObject
typedef void (^SuccessedBlock) (id obj);
typedef void (^FailedBlock) (int statusCode, int errorCode);
typedef void(^failed)(id failed);
@end
