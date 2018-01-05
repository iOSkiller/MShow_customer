//
//  YYDatePickerView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/4.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYDatePickerViewType) {
    YYDatePickerViewTypeYearMonthDayTimeDuration,
    YYDatePickerViewTypeReturnDate,
    YYDatePickerViewTypeBirthDay,
};

@interface YYDatePickerView : UIView
@property (nonatomic, assign) YYDatePickerViewType type;
@property (nonatomic, assign) NSUInteger timeDuration;
@property (nonatomic, copy) void (^didSelectDateAndTimeBlock)(NSString *date, NSString *time);
@property (nonatomic, copy) void (^didSelectBirthDayBlock)(NSString *birthDay);
- (void)selectDefaultDate;

@end
