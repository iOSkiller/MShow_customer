//
//  YYMineFunctionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMineFunctionView : UIView
- (void)setTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray countArray:(NSArray *)countArray;

@property (nonatomic, copy) void (^tapActionBlock)(NSUInteger index);

@end
