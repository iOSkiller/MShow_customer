//
//  YYSelectShopViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectShopViewCell.h"
#import "YYShopGoodsDisplayView.h"
#import "YYShopStarView.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"

@interface YYSelectShopViewCell ()
@property (nonatomic, weak) UIImageView *logoView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *saleLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) YYShopGoodsDisplayView *displayView;
@property (nonatomic, weak) YYShopStarView *starView;

@end

@implementation YYSelectShopViewCell

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
        
        WS(ws);
        [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(28));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(80)));
        }];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(38));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(40)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoView.mas_right).offset(RELATIVE_WIDTH(16));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(38));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(190), RELATIVE_WIDTH(28)));
        }];
        
        [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(130), RELATIVE_WIDTH(28)));
        }];
        
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.centerX.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(48)));
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.saleLabel);
//            make.left.equalTo(self.saleLabel.mas_right).offset(RELATIVE_WIDTH(8));
            make.left.equalTo(self.starView);
        }];
        
        [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.logoView.mas_bottom);
            make.left.right.bottom.equalTo(ws.contentView);
        }];
        
        
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
}

- (void)buttonAction
{
    if (_gotoShopBlock) {
        _gotoShopBlock([YYShopModel new]);
    }
}

@end
