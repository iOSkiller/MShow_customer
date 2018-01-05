//
//  YYWithDrawInfoView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYWithDrawInfoView : UIView
@property (nonatomic, copy) void (^didEndEdite)(NSString *sum);
@property (nonatomic, assign) double maxCash;
- (void)hideKeyBoard;

@end
