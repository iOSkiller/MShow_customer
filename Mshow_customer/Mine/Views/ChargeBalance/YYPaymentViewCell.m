//
//  YYChargeBalanceViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYPaymentViewCell.h"

@interface YYPaymentViewCell ()
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation YYPaymentViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
        self.accessoryView = button;
        _selectButton = button;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = YYTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
    }
    return self;
}

- (void)selectAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_selectBlock) {
        _selectBlock(sender.isSelected);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectButton.selected = selected;
}

@end
