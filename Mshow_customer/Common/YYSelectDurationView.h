//
//  YYSelectDurationView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSelectDurationView : UIView
@property (nonatomic, copy) NSArray *selectionArray;
@property (nonatomic, copy) void (^didSelectDurationBlock)(NSUInteger days);
- (void)hide;
- (void)show;

@end
