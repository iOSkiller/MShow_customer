//
//  YYMineAddressManagerViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineAddressManagerViewCell.h"
#import "YYButton.h"
#import "YYAddressModel.h"

@interface YYMineAddressManagerViewCell ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UILabel *phoneLabel;
@property (nonatomic, weak) YYButton *defaultButton;
@property (nonatomic, weak) YYButton *editeButton;
@property (nonatomic, weak) YYButton *deleteButton;
@property (nonatomic, weak) UIView *line;

@end

@implementation YYMineAddressManagerViewCell

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"某某某 女士";
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYGrayTextColor;
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"18306118609";
        [self.contentView addSubview:label];
        _phoneLabel = label;
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textColor = YYGrayTextColor;
        label.text = @"江苏省-南京市-鼓楼区-亚都大厦715室";
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _addressLabel = label;
    }
    return _addressLabel;
}

- (YYButton *)defaultButton {
    if (!_defaultButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"设为默认地址" selectedRightTitle:@"默认地址"];
        [button addTarget:self action:@selector(changeDefaultAction:) forControlEvents:UIControlEventTouchUpInside];
        button.normalColor = YYGrayTextColor;
        button.titleLeftMargin = RELATIVE_WIDTH(8);
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        [self.contentView addSubview:button];
        _defaultButton = button;
    }
    return _defaultButton;
}

- (YYButton *)editeButton {
    if (!_editeButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"img_modification"] selectedLeftImage:[UIImage imageNamed:@"img_modification"] rightTitle:@"编辑" selectedRightTitle:@"编辑"];
        [button addTarget:self action:@selector(editeAction) forControlEvents:UIControlEventTouchUpInside];
        button.normalColor = YYGrayTextColor;
        button.titleLeftMargin = RELATIVE_WIDTH(8);
        [self.contentView addSubview:button];
        _editeButton = button;
    }
    return _editeButton;
}

- (YYButton *)deleteButton {
    if (!_deleteButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"img_deleting"] selectedLeftImage:[UIImage imageNamed:@"img_deleting"] rightTitle:@"删除" selectedRightTitle:@"删除"];
        [button addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        button.normalColor = YYGrayTextColor;
        button.titleLeftMargin = RELATIVE_WIDTH(8);
        [self.contentView addSubview:button];
        _deleteButton = button;
    }
    return _deleteButton;
}

- (UIView *)line {
    if (!_line) {
        UIView *line = [UIView new];
        line.backgroundColor = YYSeparatorColor;
        [self.contentView addSubview:line];
        _line = line;
    }
    return _line;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self nameLabel];
        [self phoneLabel];
        [self addressLabel];
        [self defaultButton];
        [self editeButton];
        [self deleteButton];
        [self line];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(ws);
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(80));
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(320), RELATIVE_WIDTH(32)));
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(250), RELATIVE_WIDTH(32)));
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        
        [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
            make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.width.mas_equalTo(RELATIVE_WIDTH(250));
        }];
        
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
            make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.width.mas_equalTo(RELATIVE_WIDTH(130));
        }];
        
        [self.editeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.deleteButton.mas_left).offset(-RELATIVE_WIDTH(60));
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
            make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.width.mas_equalTo(RELATIVE_WIDTH(130));
        }];
    }
    return self;
}

- (void)setAddressModel:(YYAddressModel *)addressModel
{
    _addressModel = addressModel;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", addressModel.name, addressModel.gender];
    self.defaultButton.selected = addressModel.isDefault;
    self.addressLabel.text = [NSString stringWithFormat:@"%@-%@-%@-%@", addressModel.province, addressModel.city, addressModel.area, addressModel.detailAddress];
    self.phoneLabel.text = addressModel.phone;
}

#pragma mark - button action
- (void)changeDefaultAction:(UIButton *)sender
{
    if (!_addressModel.isDefault) {
        sender.selected = YES;
        if (_changeDefaultBlock) {
            _changeDefaultBlock(_addressModel);
        }
    }
    
}

- (void)editeAction
{
    if (_editeActionBlock) {
        _editeActionBlock(_addressModel);
    }
}

- (void)deleteAction
{
    if (_deleteActionBlock) {
        _deleteActionBlock(_addressModel);
    }
}

@end
