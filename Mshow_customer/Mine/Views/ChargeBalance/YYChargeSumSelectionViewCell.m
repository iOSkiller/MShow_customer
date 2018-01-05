//
//  YYChargeSumSelectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChargeSumSelectionViewCell.h"

@interface YYChargeSumSelectionViewCell ()
@property (nonatomic, weak) UILabel *label;

@end

@implementation YYChargeSumSelectionViewCell

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = YYTextColor.CGColor;
        label.layer.borderWidth = RELATIVE_WIDTH(2);
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.masksToBounds = YES;
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
    }
    return self;
}

- (void)setSumText:(NSString *)sumText
{
    _sumText = sumText;
    self.label.text = sumText;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.label.textColor = YYGlobalColor;
        self.label.layer.borderColor = YYGlobalColor.CGColor;
        self.label.layer.borderWidth = RELATIVE_WIDTH(2);
        self.label.layer.cornerRadius = CommonCornerRadius;
        self.label.layer.masksToBounds = YES;
    } else {
        self.label.textColor = YYTextColor;
        self.label.layer.borderColor = YYTextColor.CGColor;
        self.label.layer.borderWidth = RELATIVE_WIDTH(2);
        self.label.layer.cornerRadius = CommonCornerRadius;
        self.label.layer.masksToBounds = YES;
    }
}

@end
