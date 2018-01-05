//
//  YYHistoryFunctionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYHistoryFunctionViewDelegate <NSObject>
- (void)executeDelete;

@end

@interface YYHistoryFunctionView : UIView
@property (nonatomic, weak) id <YYHistoryFunctionViewDelegate> delegate;
@property (nonatomic, assign) CGRect originalFrame;

- (void)hide;
- (void)show;

@end
