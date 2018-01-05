//
//  YYSelectGenderTableViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectGenderTableViewCell.h"
#import "YYButton.h"
#import "YYGoodsModel.h"

#define imgSize CGSizeMake(RELATIVE_WIDTH(232), RELATIVE_WIDTH(212))

@interface YYSelectGenderTableViewCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *feeLabel;
@property (nonatomic, weak) UILabel *shopLabel;
@property (nonatomic, weak) YYButton *shopButton;

@end

@implementation YYSelectGenderTableViewCell

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(34)];
        label.numberOfLines = 2;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UILabel *)feeLabel {
    if (!_feeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _feeLabel = label;
    }
    return _feeLabel;
}

- (UILabel *)shopLabel {
    if (!_shopLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [self.contentView addSubview:label];
        _shopLabel = label;
    }
    return _shopLabel;
}

- (YYButton *)shopButton {
    if (!_shopButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setRightImage:[UIImage imageNamed:@"img_arrow_right"] selectedRightImage:nil leftTitle:@"进店" selectedLeftTitle:nil];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _shopButton = button;
    }
    return _shopButton;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.contentView);
            make.size.mas_equalTo(imgSize);
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(22));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
            make.height.greaterThanOrEqualTo(@18);
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
        }];
        
        [self.shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
            make.centerY.equalTo(self.shopLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(88), RELATIVE_WIDTH(30)));
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.shopLabel.mas_top).offset(-RELATIVE_WIDTH(20));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(190));
            make.bottom.equalTo(self.shopLabel.mas_top).offset(-RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@0);
        }];
    }
    return self;
}

- (void)buttonAction
{
    if (_showShopDetailBlock) {
        _showShopDetailBlock(_goodsModel.shop_id);
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.imgView.image = [UIImage clipImage:[UIImage imageNamed:goodsModel.image] toRect:imgSize];
    self.shopLabel.text = goodsModel.shop_name;
    self.nameLabel.text = goodsModel.name;
    //分割字符串
    if ([goodsModel.goodsPrice hasPrefix:@"."]) {
        NSArray *array = [goodsModel.currentPrice componentsSeparatedByString:@"."];
        self.priceLabel.attributedText = [NSString stringsArray:@[@"￥", array[0], AppendString(@".", array[1])] fontsArray:@[[UIFont systemFontOfSize:RELATIVE_WIDTH(20)], [UIFont systemFontOfSize:RELATIVE_WIDTH(28)], [UIFont systemFontOfSize:RELATIVE_WIDTH(20)]] colorsArray:@[YYGlobalColor, YYGlobalColor, YYGlobalColor]];

    }
    self.feeLabel.attributedText = [NSString stringsArray:@[@"体验费", @"￥", @"10", @".00元/天"] fontsArray:@[[UIFont systemFontOfSize:RELATIVE_WIDTH(20)], [UIFont systemFontOfSize:RELATIVE_WIDTH(20)], [UIFont systemFontOfSize:RELATIVE_WIDTH(28)], [UIFont systemFontOfSize:RELATIVE_WIDTH(20)],] colorsArray:@[YYGrayTextColor, YYGlobalColor, YYGlobalColor, YYGlobalColor]];
}

@end
