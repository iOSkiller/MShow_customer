//
//  YYCommonButton.m
//  DDFood
//
//  Created by YZ Y on 16/6/4.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYCommonButton.h"

@implementation YYCommonButton
+ (YYCommonButton *)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action
{
    YYCommonButton *button = [YYCommonButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (![selectedTitle isEqualToString:@""] && selectedTitle != nil) {
        [button setTitle:selectedTitle forState:UIControlStateSelected];
    }
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:YYGlobalColor forState:UIControlStateSelected];
    [button addTarget:selectedTitle action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (YYCommonButton *)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)tatget action:(SEL)action
{
    YYCommonButton *button = [YYCommonButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (![selectedImage isEqualToString:@""] && selectedImage != nil) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    [button addTarget:tatget action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (YYCommonButton *)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title target:(id)tatget action:(SEL)action
{
    YYCommonButton *button = [YYCommonButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (![selectedImage isEqualToString:@""] && selectedImage != nil) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    [button addTarget:tatget action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleH = RELATIVE_WIDTH(33);
    CGFloat titleY = contentRect.size.height * 0.45;
    CGFloat strLength = [self.currentTitle getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(26)] size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(66))].size.width;
    CGFloat titleW = strLength;
    CGFloat titleX = RELATIVE_WIDTH(44);
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgW = RELATIVE_WIDTH(33);
    CGFloat imgH = self.currentImage.size.height;
    CGFloat imgX = contentRect.size.height * 0.18;
    CGFloat imgY = contentRect.size.height * 0.2;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

@end
