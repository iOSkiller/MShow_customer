//
//  YYMyWalletView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYMyWalletViewDelegate <NSObject>
- (void)executeCharge;
- (void)executeWithDrawCash;
- (void)executeShowHelp;

@end

@interface YYMyWalletView : UIView
@property (nonatomic, weak) id <YYMyWalletViewDelegate> delegate;

@end
