//
//  YYSectionIndexViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSectionIndexViewCell : UITableViewCell
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;

@end
