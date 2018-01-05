//
//  YYTextView.h
//  DDFood
//
//  Created by YZ Y on 16/7/11.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYTextView : UIView
/**占位文字*/
@property (nonatomic, copy) NSString *placeHolder;
/**占位文字颜色*/
@property (nonatomic, strong) UIColor *placeHolderTextColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) BOOL hidePlaceHolder;
/**最大字数*/
@property (nonatomic, assign) int maxTextCount;
/**字数提示信息*/
@property (nonatomic, copy) NSString *numLabelText;
@property (nonatomic, assign) BOOL isShowNumLabel;
@property (nonatomic, assign) BOOL isShowPlaceHolder;
/**当前字数*/
@property (nonatomic, assign) int theNowTextNum;

@property (nonatomic, copy) void(^textDidChangeBlock)(CGSize textSize, NSString *text);
- (void)setPlaceHolder:(NSString *)placeHolder placeHolderTextColor:(UIColor *)placeHolderTextColor;

@end
