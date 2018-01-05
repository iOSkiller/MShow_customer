//
//  UILabel+YYExtension.h
//  Mshow_customer
//
//  Created by YYZ on 2018/1/2.
//  Copyright © 2018年 YYZ. All rights reserved.
//


@interface UILabel (YYExtension)
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
