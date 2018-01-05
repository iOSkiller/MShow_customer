//
//  YYNaviBarButton.m
//  DDFood
//
//  Created by YZ Y on 16/12/30.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYNaviBarButton.h"

@implementation YYNaviBarButton
+ (YYNaviBarButton *)buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    YYNaviBarButton *button = [YYNaviBarButton buttonWithType:UIButtonTypeCustom];
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
    button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(18)];
    
    return button;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.8;
    CGFloat titleH = RELATIVE_WIDTH(26);
    CGFloat strLength = [self.currentTitle getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(18)] size:CGSizeMake(33, 33)].size.width;
    CGFloat titleW = strLength;

    return CGRectMake(RELATIVE_WIDTH(30), titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    //    UIImage *image = self.currentImage;
    //    CGFloat imgW = RELATIVE_WIDTH(image.size.width*2);
    CGFloat imgW = RELATIVE_WIDTH(40);
    
    CGFloat imgY = 2.2;
    return CGRectMake(RELATIVE_WIDTH(30), imgY, imgW, imgW);
}
@end
