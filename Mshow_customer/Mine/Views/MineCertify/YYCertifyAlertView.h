//
//  YYCertifyAlertView.h
//  Mshow_customer
//
//  Created by YYZ on 2018/1/2.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCertifyAlertView : UIView
@property (nonatomic, copy) void (^nameBlock)(NSString *name);
@property (nonatomic, copy) void (^codeBlock)(NSString *code);

@end
