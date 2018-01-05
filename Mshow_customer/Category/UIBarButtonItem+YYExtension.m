//
//  UIBarButtonItem+YYExtension.m
//  Service1.0
//
//  Created by YZ Y on 16/4/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "UIBarButtonItem+YYExtension.h"
#import "YYBarButton.h"

@implementation UIBarButtonItem (YYExtension)
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    if (title != nil && ![title isEqualToString:@""] && image != nil && ![image isEqualToString:@""]) {
        YYBarButton *button = [YYBarButton buttonWithTitle:title normalColor:YYDiscriptionColor selectedTitle:selectedTitle selectedColor:[UIColor whiteColor] image:image selectedImage:highImage target:target action:action];
        return [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title != nil && ![title isEqualToString:@""]) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:selectedTitle forState:UIControlStateSelected];
        [button setTitleColor:YYTextColor forState:UIControlStateNormal];
        [button setTitleColor:YYGlobalColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        button.bounds = CGRectMake(0, 0, 44, 44);
    }
    if (image != nil && ![image isEqualToString:@""]) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        button.bounds = (CGRect){CGPointZero,[button imageForState:UIControlStateNormal].size};
    }
    if (highImage != nil && ![highImage isEqualToString:@""]) {
        [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
        button.bounds = (CGRect){CGPointZero,[button imageForState:UIControlStateSelected].size};
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}
@end
