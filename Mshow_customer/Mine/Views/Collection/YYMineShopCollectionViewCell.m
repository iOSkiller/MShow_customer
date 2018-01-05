//
//  YYMineShopCollectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineShopCollectionViewCell.h"
#import "YYShopModel.h"
#import "YYGoodsModel.h"
#import "YYShopGoodsDisplayView.h"
#import "YYShopStarView.h"

@interface YYMineShopCollectionViewCell ()
@property (nonatomic, weak) UIImageView *logoView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *saleLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, weak) YYShopGoodsDisplayView *displayView;
@property (nonatomic, weak) YYShopStarView *starView;

@end

@implementation YYMineShopCollectionViewCell

- (UIImageView *)logoView {
    if (!_logoView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = mRGBToColor(0xcccccc);
        [self.contentView addSubview:view];
        _logoView = view;
    }
    return _logoView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"THERO";
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)saleLabel {
    if (!_saleLabel) {
        UILabel *label = [UILabel new];
        label.textColor = mRGBToColor(0x626262);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"销量233";
        [self.contentView addSubview:label];
        _saleLabel = label;
    }
    return _saleLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.textColor = mRGBToColor(0x626262);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"共245单品";
        [self.contentView addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"进店" forState:UIControlStateNormal];
        [button setTitleColor:mRGBToColor(0x626262) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.borderColor = mRGBToColor(0xcfcfcf).CGColor;
        button.layer.borderWidth = RELATIVE_WIDTH(2);
        button.layer.masksToBounds = YES;
        [self.contentView addSubview:button];
        _button = button;
    }
    return _button;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}


- (YYShopGoodsDisplayView *)displayView {
    if (!_displayView) {
        YYShopGoodsDisplayView *view = [[YYShopGoodsDisplayView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(310))];
        [self.contentView addSubview:view];
        _displayView = view;
    }
    return _displayView;
}

- (YYShopStarView *)starView {
    if (!_starView) {
        YYShopStarView *view = [[YYShopStarView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(200), RELATIVE_WIDTH(48))];
        [view setStarsCount:5 starImage:[UIImage imageNamed:@"img_star"]];
        [self.contentView addSubview:view];
        _starView = view;
    }
    return _starView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self logoView];
        [self nameLabel];
        [self saleLabel];
        [self countLabel];
        [self button];
        [self displayView];
        [self starView];
        self.displayView.tapActionBlock = ^(YYGoodsModel *model) {
            if (_showGoodsBlock) {
                _showGoodsBlock(model);
            }
        };
    }
    return self;
}

- (void)setShopModel:(YYShopModel *)shopModel
{
    _shopModel = shopModel;
    self.nameLabel.text = shopModel.shopName;
    self.saleLabel.text = [NSString stringWithFormat:@"销量%@", shopModel.saleCount];
    self.countLabel.text = [NSString stringWithFormat:@"共%@单品", shopModel.goodsCount];
    self.displayView.goodsArray = shopModel.goodsArray;
    if (_isEditing) {
        self.selectButton.selected = shopModel.isSelected;
    }
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    WS(ws);
    if (isEditing) {
        self.selectButton.selected = NO;
        self.selectButton.hidden = NO;
        
        [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(ws.contentView);
            make.width.mas_equalTo(RELATIVE_WIDTH(84));
        }];
        
        [self.logoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectButton.mas_right).offset(RELATIVE_WIDTH(26));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(28));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(80)));
        }];
        
        [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(38));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(40)));
        }];
        
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoView.mas_right).offset(RELATIVE_WIDTH(16));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(38));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(190), RELATIVE_WIDTH(28)));
        }];
        
        [self.saleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(130), RELATIVE_WIDTH(28)));
        }];
        
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.saleLabel);
            make.left.equalTo(self.saleLabel.mas_right).offset(RELATIVE_WIDTH(8));
        }];
        
        [self.displayView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.logoView.mas_bottom);
            make.right.bottom.equalTo(ws.contentView);
            make.left.equalTo(self.selectButton.mas_right);
        }];
        
        [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.centerX.equalTo(ws.contentView).mas_offset(RELATIVE_WIDTH(42));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(48)));
        }];
    } else {
        self.selectButton.hidden = YES;
        [self.selectButton removeFromSuperview];
        [self.logoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(28));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(80)));
        }];
        
        [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(38));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(40)));
        }];
        
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoView.mas_right).offset(RELATIVE_WIDTH(16));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(38));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(190), RELATIVE_WIDTH(28)));
        }];
        
        [self.saleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(130), RELATIVE_WIDTH(28)));
        }];
        
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.saleLabel);
            make.left.equalTo(self.saleLabel.mas_right).offset(RELATIVE_WIDTH(8));
        }];
        
        [self.displayView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.logoView.mas_bottom);
            make.left.right.bottom.equalTo(ws.contentView);
        }];
        
        [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.centerX.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(48)));
        }];
    }
    
    
}

- (void)buttonAction
{
    if (_gotoShopBlock) {
        _gotoShopBlock([YYShopModel new]);
    }
}

- (void)selectAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_selectShopBlock) {
        _selectShopBlock(_shopModel, sender.isSelected);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (_isEditing) {
        
    }
}

@end
