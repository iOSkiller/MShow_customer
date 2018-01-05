//
//  YYNotificationHandle.h
//  DDFood
//
//  Created by YZ Y on 17/2/21.
//  Copyright © 2017年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYNotificationHandle : NSObject
/**发送本地推送*/
+ (void)sendLocationNotification:(double)intervalTime;

@end
