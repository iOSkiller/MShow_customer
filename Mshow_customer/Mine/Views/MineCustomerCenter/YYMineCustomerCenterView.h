//
//  YYMineCustomerCenterView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYMineCustomerCenterViewDelegate <NSObject>
- (void)executeShowAllQuestion;
- (void)executeShowQuestion:(NSString *)questionID;
- (void)executeCall;

@end

@interface YYMineCustomerCenterView : UIView
@property (nonatomic, weak) id <YYMineCustomerCenterViewDelegate> delegate;

@end
