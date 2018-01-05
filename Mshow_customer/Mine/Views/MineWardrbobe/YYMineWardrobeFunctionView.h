//
//  YYMineWardrobeFunctionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMineWardrobeFunctionView : UIView
- (instancetype)initWithFrame:(CGRect)frame functionArray:(NSArray *)functionArray haveDealInfo:(NSString *)dealInfo;
@property (nonatomic, assign) YYDealStatusType statusType;
@property (nonatomic, copy) void (^buttonActionBlock)(YYMineFunctionType type);
@property (nonatomic, copy) NSString *dealInfo;

@end
