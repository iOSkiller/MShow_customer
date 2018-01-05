//
//  YYMineSizeSelectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineSizeSelectionViewCell.h"

@interface YYMineSizeSelectionViewCell ()
@property (nonatomic, weak) UILabel *label;

@end

@implementation YYMineSizeSelectionViewCell

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
//        label.layer.cornerRadius = CommonCornerRadius;
//        label.layer.borderColor = [UIColor clearColor].CGColor;
//        label.layer.masksToBounds = YES;
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _label = label;
    }
    return _label;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self label];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.label.text = title;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.label.backgroundColor = isSelected ? YYGlobalColor : [UIColor whiteColor];
    self.label.textColor = isSelected ? [UIColor whiteColor] : YYTextColor;
}

@end
