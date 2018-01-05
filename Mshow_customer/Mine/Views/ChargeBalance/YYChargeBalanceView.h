//
//  YYChargeBalanceView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYChargeBalanceViewDelegate <NSObject>
- (void)executeChangeBalance:(NSString *)balanceSum paytype:(YYPayType)paytype;

@end

@interface YYChargeBalanceView : UIView
@property (nonatomic, weak) id <YYChargeBalanceViewDelegate> delegate;

@end
