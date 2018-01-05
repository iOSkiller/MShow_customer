//
//  YYCommonButton.h
//  DDFood
//
//  Created by YZ Y on 16/6/4.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCommonButton : UIButton
+ (YYCommonButton *)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action;
+ (YYCommonButton *)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)tatget action:(SEL)action;
+ (YYCommonButton *)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title target:(id)tatget action:(SEL)action;

@end
