//
//  YYSelectDurationViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"
#import "YYSelectRentDurationView.h"

@interface YYSelectDurationViewController : YYBaseViewController
@property (nonatomic, copy) void (^didFinishSelectDuration)(NSUInteger days, NSString *dateForRecieve);
- (void)setType:(YYSelectRentDurationViewType)type dateForRecieve:(NSDate *)dateForRecieve;
@end
