//
//  YYSettingView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYSettingViewDelegate <NSObject>
- (void)executeResetPassword;
- (void)executeCleanMemmory;
- (void)executeShowMshow;
- (void)executeLogout;

@end

@interface YYSettingView : UIView
@property (nonatomic, weak) id <YYSettingViewDelegate> delegate;
- (void)logouSuccess;

@end
