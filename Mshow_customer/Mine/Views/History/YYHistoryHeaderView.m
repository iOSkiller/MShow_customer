//
//  YYHistoryHeaderView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryHeaderView.h"

@interface YYHistoryHeaderView ()
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation YYHistoryHeaderView

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(24), 0, WIN_WIDTH - RELATIVE_WIDTH(48), RELATIVE_WIDTH(60))];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYGrayTextColor;
        label.text = @"2017-10-18";
        label.backgroundColor = mRGBToColor(0xf0f0f0);
        [self addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self selectButton];
        [self dateLabel];
    }
    return self;
}

- (void)setDate:(NSString *)date
{
    _date = date;
    _dateLabel.text = date;
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    WS(ws);
    if (isEditing) {
        self.selectButton.hidden = NO;
        [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectButton.mas_right).offset(RELATIVE_WIDTH(20));
            make.centerY.equalTo(ws);
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
    } else {
        self.selectButton.hidden = YES;
        [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.centerY.equalTo(ws);
        }];
    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.selectButton.selected = isSelected;
}

- (void)selectButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_selectBlock) {
        _selectBlock(sender.isSelected);
    }
}

@end
