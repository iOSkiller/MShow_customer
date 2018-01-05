//
//  YYSelectTypeSelectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectTypeSelectionViewCell.h"
#import "YYTypeSelectionModel.h"

@interface YYSelectTypeSelectionViewCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *line;

@end

@implementation YYSelectTypeSelectionViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)line {
    if (!_line) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYGlobalColor;
        label.hidden = YES;
        [self.contentView addSubview:label];
        _line = label;
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self titleLabel];
        WS(ws);
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
        }];
        
    }
    return self;
}

- (void)setModel:(YYTypeSelectionModel *)model
{
    _model = model;
    self.titleLabel.text = model.content;
    CGFloat width = [self.titleLabel.text getStringRect:self.titleLabel.font size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(32))].size.width;
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.titleLabel);
        make.height.mas_equalTo(RELATIVE_WIDTH(2));
        make.width.mas_equalTo(width);
    }];
    [self.contentView bringSubviewToFront:self.line];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.line.hidden = !selected;
}


@end
