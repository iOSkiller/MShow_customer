//
//  YYNaviBarButton.h
//  DDFood
//
//  Created by YZ Y on 16/12/30.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYNaviBarButton : UIButton
+ (YYNaviBarButton *)buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;
@end