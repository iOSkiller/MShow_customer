//
//  YYSectionIndexViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSectionIndexViewCell.h"

@interface YYSectionIndexViewCell ()
@property (nonatomic, weak) UILabel *label;

@end

@implementation YYSectionIndexViewCell

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYTextColor;
        label.layer.cornerRadius = RELATIVE_WIDTH(15);
        label.layer.masksToBounds = YES;
        [self.contentView addSubview:label];
        _label = label;
    }
    return _label;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectedColor = YYGlobalColor;
        self.normalColor = [UIColor whiteColor];
        self.backgroundColor = self.normalColor;
        WS(ws);
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(30), RELATIVE_WIDTH(30)));
            make.center.equalTo(ws.contentView);
        }];
    }
    return self;
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    self.label.backgroundColor = normalColor;
    self.backgroundColor = normalColor;
}

- (void)setText:(NSString *)text
{
    self.label.text = text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.label.backgroundColor = self.selectedColor;
        self.label.textColor = [UIColor whiteColor];
    } else {
        self.label.backgroundColor = self.normalColor;
        self.label.textColor = YYTextColor;
    }
}



@end
