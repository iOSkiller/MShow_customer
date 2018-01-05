//
//  YYShoppingCartViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShoppingCartViewCell.h"
#import "YYButton.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"
#import "YYShoppingCartGoodsInfoView.h"

@interface YYShoppingCartViewCell ()
@property (nonatomic, weak) UILabel *shopLabel;
@property (nonatomic, weak) UIImageView *shopIconView;
@property (nonatomic, weak) UIButton *shopButton;
@property (nonatomic, weak) UILabel *line;
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, weak) UIButton *couponButton;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIImageView *arrowView;

@property (nonatomic, weak) YYShoppingCartGoodsInfoView *infoView;
@property (nonatomic, weak) UIView *containerView;


@end

@implementation YYShoppingCartViewCell

- (UIView *)containerView {
    if (!_containerView) {
        UIView *view = [UIView new];
        view.backgroundColor = mRGBToColor(0xfafafa);
        [self.contentView addSubview:view];
        _containerView = view;
    }
    return _containerView;
}

- (UILabel *)shopLabel {
    if (!_shopLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"某某店铺";
        [self.contentView addSubview:label];
        _shopLabel = label;
    }
    return _shopLabel;
}


- (UIButton *)shopButton {
    if (!_shopButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(shopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _shopButton = button;
    }
    return _shopButton;
}

- (UIImageView *)shopIconView {
    if (!_shopIconView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_shop"]];
        [self.contentView addSubview:view];
        _shopIconView = view;
    }
    return _shopIconView;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
        [self.contentView addSubview:view];
        _arrowView = view;
    }
    return _arrowView;
}

- (UIButton *)couponButton {
    if (!_couponButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"领券" forState:UIControlStateNormal];
        [button setTitleColor:YYTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [button addTarget:self action:@selector(couponButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _couponButton = button;
    }
    return _couponButton;
}


- (UILabel *)line {
    if (!_line) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        [self.contentView addSubview:label];
        _line = label;
    }
    return _line;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(goodsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor orangeColor];
        [self.containerView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (YYShoppingCartGoodsInfoView *)infoView {
    if (!_infoView) {
        YYShoppingCartGoodsInfoView *view = [[YYShoppingCartGoodsInfoView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(200), RELATIVE_WIDTH(500))];
        view.backgroundColor = mRGBToColor(0xfafafa);
        [self.containerView addSubview:view];
        _infoView = view;
    }
    return _infoView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self selectButton];
        [self imgView];
        [self infoView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setIsFirstCell:(BOOL)isFirstCell
{
    _isFirstCell = isFirstCell;
    self.shopLabel.hidden = !isFirstCell;
    self.shopButton.hidden = !isFirstCell;
    self.line.hidden = !isFirstCell;
    self.shopIconView.hidden = !isFirstCell;
    
    self.containerView.hidden = isFirstCell;
    
    WS(ws);
    if (_isFirstCell) {
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(80));
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(2));
        }];
        
        [self.shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(40));
        }];
        
        [self.shopIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shopButton);
            make.left.equalTo(self.shopButton.mas_right).offset(RELATIVE_WIDTH(10));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(40));
        }];
        
        CGFloat labelWidth = [self.shopLabel.text getStringRect:self.shopLabel.font size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(32))].size.width + RELATIVE_WIDTH(10);
        
        [self.shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shopButton);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.mas_equalTo(labelWidth);
            make.left.equalTo(self.shopIconView.mas_right).offset(RELATIVE_WIDTH(10));
        }];
        
        [self.couponButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shopLabel);
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(66), RELATIVE_WIDTH(33)));
        }];
        
        [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shopLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(21), RELATIVE_WIDTH(21)));
            make.left.equalTo(self.shopLabel.mas_right).offset(RELATIVE_WIDTH(20));
        }];
    }
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.contentView);
        make.top.equalTo(ws.contentView);
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(RELATIVE_WIDTH(24));
        make.top.equalTo(self.containerView).offset(RELATIVE_WIDTH(148));
        make.width.height.mas_equalTo(RELATIVE_WIDTH(40));
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectButton.mas_right).offset(RELATIVE_WIDTH(10));
        make.top.equalTo(self.containerView).offset(RELATIVE_WIDTH(30));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(180), RELATIVE_WIDTH(250)));
        //        make.width.mas_equalTo(RELATIVE_WIDTH(180));
        //        make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(30));
    }];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right);
        make.right.bottom.equalTo(ws.contentView);
        make.top.equalTo(self.containerView);
    }];
}

- (void)setShopModel:(YYShopModel *)shopModel
{
    _shopModel = shopModel;
    self.shopButton.selected = shopModel.isSelected;
    self.shopLabel.text = shopModel.shopName;
    self.couponButton.hidden = !shopModel.isCouponed;
    
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.selectButton.selected = goodsModel.isSelected;
    [self.imgView performSelector:@selector(setImage:) withObject:[UIImage clipImage:[UIImage imageNamed:goodsModel.image] toRect:self.imgView.mj_size] afterDelay:0.2 inModes:@[NSDefaultRunLoopMode]];
    self.infoView.goodsModel = goodsModel;
}

#pragma mark - button action
- (void)shopButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    _shopModel.isSelected = sender.selected;
    if (_didChangeShopBlock) {
        _didChangeShopBlock(_shopModel);
    }
}

- (void)goodsButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    _goodsModel.isSelected = sender.selected;
    if (_didChangeGoodsBlock) {
        _didChangeGoodsBlock(_goodsModel);
    }
}

- (void)couponButtonAction
{
    if (_showCouponBlock) {
        _showCouponBlock(_shopModel);
    }
}


@end
