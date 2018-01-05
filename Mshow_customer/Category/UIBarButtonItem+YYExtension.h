//
//  UIBarButtonItem+YYExtension.h
//  Service1.0
//
//  Created by YZ Y on 16/4/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YYExtension)
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
