//
//  YYSelectRentDurationView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYSelectRentDurationViewType) {
    YYSelectRentDurationViewTypeDate,
    YYSelectRentDurationViewTypeDuration,
};

@protocol YYSelectRentDurationViewDelegate <NSObject>
- (void)executeSureAction:(NSUInteger)duration dateForRecieve:(NSString *)date;

@end

@interface YYSelectRentDurationView : UIView
@property (nonatomic, weak) id <YYSelectRentDurationViewDelegate> delegate;
@property (nonatomic, assign) YYSelectRentDurationViewType type;
- (void)setDate:(NSDate *)date;

@end
