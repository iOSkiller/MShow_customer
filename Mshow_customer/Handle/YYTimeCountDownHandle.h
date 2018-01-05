//
//  YYTimeCountDownHandle.h
//  DDFood
//
//  Created by YZ Y on 17/1/16.
//  Copyright © 2017年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYTimeCountDownHandle : NSObject
/**用NSDate日期倒计时*/
- (void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completeBlock;
/**用时间戳倒计时*/
- (void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completeBlock;
/**每秒走一次，回调block*/
- (void)countDownWithPER_SECBlock:(void (^)(void))PER_SECBlock;
/**销毁计时器*/
- (void)destoryTimer;
- (NSDate *)dateWithLongLong:(long long)longlongValue;

@end
