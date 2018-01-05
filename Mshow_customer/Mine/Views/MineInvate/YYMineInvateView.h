//
//  YYMineInvateView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYMineInvateViewDelegate <NSObject>
- (void)executeInvateFriend:(NSString *)invateCode;
- (void)executeShowInvateConsolation;

@end

@interface YYMineInvateView : UIView
@property (nonatomic, weak) id <YYMineInvateViewDelegate> delegate;

@end
