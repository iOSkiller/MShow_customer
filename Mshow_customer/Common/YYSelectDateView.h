//
//  YYSelectDateView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSelectDateView : UIView
@property (nonatomic, copy) void (^selectDateBlock)(NSInteger day, NSInteger month, NSInteger year);
@property (nonatomic, assign) NSUInteger duration;
@property (nonatomic, assign) BOOL hideInfoLabel;

- (void)setDateForRecieve:(NSDate *)dateForRecieve;

@end
