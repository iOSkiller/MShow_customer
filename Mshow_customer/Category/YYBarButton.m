//
//  YYBarButton.m
//  DDFood
//
//  Created by YZ Y on 16/6/3.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYBarButton.h"

@implementation YYBarButton

+ (YYBarButton *)buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    YYBarButton *button = [YYBarButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    if (normalColor == nil) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor == nil) {
        [button setTitleColor:YYDiscriptionColor forState:UIControlStateSelected];
    } else {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (selectedImage != nil) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
    
//    button.backgroundColor = [UIColor orangeColor];
    return button;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height - RELATIVE_WIDTH(24);
    CGFloat titleH = RELATIVE_WIDTH(24);
    CGFloat strLength = [self.currentTitle getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(20)] size:CGSizeMake(33, 33)].size.width;
    CGFloat titleW = strLength;
    CGFloat titleX = (contentRect.size.width - titleW) / 2;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgW = self.currentImage.size.width;
    CGFloat imgH = self.currentImage.size.height;
    CGFloat imgX = (contentRect.size.width - imgW) / 2;
    CGFloat imgY = contentRect.size.height - RELATIVE_WIDTH(24) - imgW;
    return CGRectMake(imgX, imgY, imgW, imgH);
}


@end
