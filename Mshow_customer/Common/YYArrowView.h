//
//  YYArrowView.h
//  DDFood
//
//  Created by YZ Y on 16/10/18.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYArrowViewType) {
    YYArrowViewTypeLine,
    YYArrowViewTypeBlock
};

typedef NS_ENUM(NSInteger, YYArrowViewDirection) {
    YYArrowViewDirectionLeft,
    YYArrowViewDirectionRight,
    YYArrowViewDirectionDown,
    YYArrowViewDirectionUP,
};

@interface YYArrowView : UIView
- (instancetype)initWithFrame:(CGRect)frame fillColor:(UIColor *)fillColor direction:(YYArrowViewDirection)direction;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) YYArrowViewType type;

@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;

@end
