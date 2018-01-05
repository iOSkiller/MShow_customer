//
//  YYBottomSelectView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYBottomSelectViewType) {
    YYBottomSelectViewTypeRecieve,
    YYBottomSelectViewTypeDelviery,
    YYBottomSelectViewTypeDateTime,
    YYBottomSelectViewTypeBirthDay,
    YYBottomSelectViewTypeReturnDateTime,
};

@interface YYBottomSelectView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(YYBottomSelectViewType)type;
@property (nonatomic, copy) void (^didFinishSelectBlock)(YYMineFunctionType functionType);
@property (nonatomic, copy) void (^didSelectDateAndTimeBlock)(NSString *date, NSString *time);
@property (nonatomic, copy) void (^didSelectBirthDayBlock)(NSString *birthDay);
@property (nonatomic, weak) UIButton *sureButton;

- (void)show;
- (void)hide;

@end
