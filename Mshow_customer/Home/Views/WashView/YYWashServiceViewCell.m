//
//  YYWashServiceViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWashServiceViewCell.h"
#import "YYWashModel.h"

@interface YYWashServiceViewCell ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *descriptionLabel;
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, weak) UIButton *minusButton;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIView *backView;

@end

@implementation YYWashServiceViewCell

{
    NSInteger _goodsCount;
}

- (UIView *)backView {
    if (!_backView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _backView = view;
    }
    return _backView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
        label.textColor = YYTextColor;
        [self.backView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textColor = YYGrayTextColor;
        label.numberOfLines = 2;
        [self.backView addSubview:label];
        _descriptionLabel = label;
    }
    return _descriptionLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        label.textColor = YYGlobalColor;
        [self.backView addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UIView *)line {
    if (!_line) {
        UIView *line = [UIView new];
        line.backgroundColor = YYSeparatorColor;
        [self.backView addSubview:line];
        _line = line;
    }
    return _line;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGrayTextColor;
        label.numberOfLines = 2;
//        label.backgroundColor = [UIColor orangeColor];
        [self.backView addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        label.hidden = YES;
        [self.backView addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_add"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:button];
        _addButton = button;
    }
    return _addButton;
}

- (UIButton *)minusButton {
    if (!_minusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_minus"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickMinusButton) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self.backView addSubview:button];
        _minusButton = button;
    }
    return _minusButton;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        [self.backView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (void)clickAddButton
{
    if (_goodsCount < 99) {
        self.countLabel.hidden = NO;
        self.minusButton.hidden = NO;
        _goodsCount ++;
        self.countLabel.text = [NSString stringWithFormat:@"%@", @(_goodsCount)];
        if (_didSelectCountBlock) {
            _didSelectCountBlock(self.countLabel.text, _washModel);
        }
    } else {
        self.addButton.enabled = NO;
    }
    
}

- (void)clickMinusButton
{
    _goodsCount --;
    self.countLabel.text = [NSString stringWithFormat:@"%@", @(_goodsCount)];
    if (_didSelectCountBlock) {
        _didSelectCountBlock(self.countLabel.text, _washModel);
    }
    self.countLabel.hidden = _goodsCount == 0;
    self.minusButton.hidden = _goodsCount == 0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = YYSeparatorColor;
        WS(ws);
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws.contentView);
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
        }];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView).offset(RELATIVE_WIDTH(26));
            make.top.equalTo(self.backView).offset(RELATIVE_WIDTH(30));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(180)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView).offset(RELATIVE_WIDTH(30));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(26));
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
        }];
        
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(self.backView).offset(-RELATIVE_WIDTH(26));
            make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(30)));
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView).offset(RELATIVE_WIDTH(240));
            make.left.equalTo(self.backView).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(self.backView).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(18));
            make.right.left.equalTo(self.line);
            make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(26)));
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(26));
            make.bottom.equalTo(self.line.mas_top).offset(-RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(38));
        }];
        
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.line.mas_top).offset(-RELATIVE_WIDTH(30));
            make.right.equalTo(self.backView).offset(-RELATIVE_WIDTH(26));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(60));
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(48), RELATIVE_WIDTH(32)));
            make.right.equalTo(self.addButton.mas_left).offset(-RELATIVE_WIDTH(2));
            make.centerY.equalTo(self.addButton);
        }];
        
        [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.countLabel.mas_left).offset(-RELATIVE_WIDTH(2));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(60));
            make.bottom.equalTo(self.line.mas_top).offset(-RELATIVE_WIDTH(30));
        }];
        
    }
    return self;
}

- (void)setWashModel:(YYWashModel *)washModel
{
    _washModel = washModel;
    self.nameLabel.text = washModel.name;
    self.descriptionLabel.text = washModel.description_content;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/件", washModel.price];
    self.infoLabel.text = washModel.info;
    self.imgView.image = [UIImage clipImage:[UIImage imageNamed:washModel.image] toRect:CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(180))];
}

@end
