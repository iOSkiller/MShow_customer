//
//  YYButton.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYButtonImageDirection) {
    YYButtonImageDirectionLeft,
    YYButtonImageDirectionRight,
    YYButtonImageDirectionTop,
};

@interface YYButton : UIButton
- (void)setLeftImage:(UIImage *)leftImage selectedLeftImage:(UIImage *)selectedLeftImage rightTitle:(NSString *)rightTitle selectedRightTitle:(NSString *)selectedRightTitle;
- (void)setRightImage:(UIImage *)rightImage selectedRightImage:(UIImage *)selectedRightImage leftTitle:(NSString *)leftTitle selectedLeftTitle:(NSString *)selectedLeftTitle;
- (void)setTopImage:(UIImage *)topImage selectedTopImage:(UIImage *)selectedTopImage bottomTitle:(NSString *)bottomTitle selctedBottomTitle:(NSString *)selctedBottomTitle;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, assign) CGFloat titleLeftMargin;

@end
