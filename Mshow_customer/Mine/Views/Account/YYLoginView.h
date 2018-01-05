//
//  YYLoginView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYLoginViewDelegate <NSObject>
- (void)executeRegister;
- (void)executeFindCode;
- (void)executeLogin:(NSString *)phone password:(NSString *)password;

@end

@interface YYLoginView : UIView
@property (nonatomic, weak) id <YYLoginViewDelegate> delegate;

@end
