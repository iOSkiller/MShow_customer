//
//  YYHomeFunctionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHomeFunctionView : UIView
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;
@property (nonatomic, copy) void (^didSelectFuctionBlock)(YYHomeFunctionType functionType);

@end
