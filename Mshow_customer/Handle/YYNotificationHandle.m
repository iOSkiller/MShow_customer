//
//  YYNotificationHandle.m
//  DDFood
//
//  Created by YZ Y on 17/2/21.
//  Copyright © 2017年 YZ Y. All rights reserved.
//

#import "YYNotificationHandle.h"

@implementation YYNotificationHandle
+ (void)sendLocationNotification:(double)intervalTime
{
    // 1.创建一个本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 1.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:intervalTime];
    
    // 1.2.设置通知内容
    localNote.alertBody = @"今日秒杀已开始";
    
    // 1.3.设置锁屏时,字体下方显示的一个文字
    localNote.alertAction = @"今日秒杀已开始";
    localNote.hasAction = YES;
    
    // 1.4.设置启动图片(通过通知打开的)
    //localNote.alertLaunchImage = @"../Documents/IMG_0024.jpg";
    
    // 1.5.设置通过到来的声音
    localNote.soundName = UILocalNotificationDefaultSoundName;
    
    // 1.6.设置应用图标左上角显示的数字
    localNote.applicationIconBadgeNumber = 1;
    
    // 1.7.设置一些额外的信息
    //localNote.userInfo = @{@"qq" : @"704711253", @"msg" : @"success"};
    
    // 2.执行通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}
@end
