//
//  YYSelectReturnRecieveTypeViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectReturnRecieveTypeViewCell.h"

@interface YYSelectReturnRecieveTypeViewCell ()
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation YYSelectReturnRecieveTypeViewCell

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        [self.contentView addSubview:label];
        _label = label;
    }
    return _label;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(ws);
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(260));
            make.centerY.equalTo(ws.contentView);
            make.height.width.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectButton.mas_right).offset(RELATIVE_WIDTH(50));
            make.centerY.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
    }
    return self;
}

- (void)selectAction:(UIButton *)sender
{
    if (!sender.isSelected) {
        sender.selected = !sender.selected;
        if (_selectBlock) {
            _selectBlock(sender.isSelected);
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectButton.selected = selected;
}

@end
