//
//  YYWithDrawCashView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYWithDrawCashViewDelegate <NSObject>
- (void)executeWithDrawCash:(NSString *)cashSum type:(YYPayType)type;

@end

@interface YYWithDrawCashView : UIView
@property (nonatomic, weak) id <YYWithDrawCashViewDelegate> delegate;

@end
