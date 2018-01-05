//
//  NSDate+YYExtension.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YYExtension)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

//判断时间戳是否为当天,昨天,一周内,年月日
+ (NSString *)timeStringWithTimeInterval:(NSString *)timeInterval;

/**几点*/
+ (NSInteger)hour:(NSDate *)date;
/**几分*/
+ (NSInteger)minute:(NSDate *)date;
/**几秒*/
+ (NSInteger)second:(NSDate *)date;
/**计算在这个月里的第几天*/
+ (NSInteger)day:(NSDate *)date;
/**判断是在哪个月*/
+ (NSInteger)month:(NSDate *)date;
/**判断是哪一年*/
+ (NSInteger)year:(NSDate *)date;
/**判断这个月有几周*/
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
/**计算这个月有几天*/
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;
/**计算每月有几天*/
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
/**计算上个月有几天*/
+ (NSDate *)lastMonth:(NSDate *)date;
/**计算下个月有几天*/
+ (NSDate *)nextMonth:(NSDate *)date;
/**计算过几天后是几号*/
+ (NSDate *)computeDateWithDays:(NSInteger)days date:(NSDate *)date;
/**字符串转NSDate*/
+ (NSDate *)dateFromString:(NSString *)timeString dateFormate:(NSString *)dateFormate;

@end
