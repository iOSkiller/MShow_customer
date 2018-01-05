//
//  YYShoppingCartGoodsInfoView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShoppingCartGoodsInfoView.h"
#import "YYButton.h"
#import "YYGoodsModel.h"

@interface YYShoppingCartGoodsInfoView ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *colorLabel;
@property (nonatomic, weak) UILabel *marketPriceLabel;
@property (nonatomic, weak) UILabel *sizeLabel;
@property (nonatomic, weak) UILabel *discountLabel;
@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) YYButton *selectionButton1;
@property (nonatomic, weak) YYButton *selectionButton2;
@property (nonatomic, weak) YYButton *selectionButton3;
@property (nonatomic, weak) UIButton *editeButton;
@property (nonatomic, weak) UIView *infoView;

@property (nonatomic, weak) UILabel *editedCountLabel;
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, weak) UIButton *minButton;
@property (nonatomic, weak) UILabel *typeLabel;
@property (nonatomic, weak) UIButton *finishButton;
@property (nonatomic, weak) UIView *tapView;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIView *editeView;

@end

@implementation YYShoppingCartGoodsInfoView

{
    NSInteger _count;
}

- (UIView *)infoView {
    if (!_infoView) {
        UIView *view = [UIView new];
        view.backgroundColor = mRGBToColor(0xfafafa);
        [self addSubview:view];
        _infoView = view;
    }
    return _infoView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.text = @"套头衫";
        [self.infoView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)colorLabel {
    if (!_colorLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.text = @"颜色:白色";
        [self.infoView addSubview:label];
        _colorLabel = label;
    }
    return _colorLabel;
}

- (UILabel *)marketPriceLabel {
    if (!_marketPriceLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.text = @"市场价:￥400.00";
        [self.infoView addSubview:label];
        _marketPriceLabel = label;
    }
    return _marketPriceLabel;
}

- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.text = @"尺寸:S";
        [self.infoView addSubview:label];
        _sizeLabel = label;
    }
    return _sizeLabel;
}

- (UILabel *)discountLabel {
    if (!_discountLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.text = @"M秀折扣:-￥100.00";
        [self.infoView addSubview:label];
        _discountLabel = label;
    }
    return _discountLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGlobalColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.text = @"(亲，选择秀全新件不可剪标哦)";
        [self.infoView addSubview:label];
        _tipLabel = label;
    }
    return _tipLabel;
}

- (UIButton *)editeButton {
    if (!_editeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_modification"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(editeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.infoView addSubview:button];
        _editeButton = button;
    }
    return _editeButton;
}

- (YYButton *)selectionButton1 {
    if (!_selectionButton1) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"买这件￥300.00" selectedRightTitle:@"买这件￥300.00"];
        [button addTarget:self action:@selector(selectionAction1:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = mRGBToColor(0xfafafa);
        button.imageSize = CGSizeMake(RELATIVE_WIDTH(30), RELATIVE_WIDTH(30));
        [self.infoView addSubview:button];
        _selectionButton1 = button;
    }
    return _selectionButton1;
}

- (YYButton *)selectionButton2 {
    if (!_selectionButton2) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"秀试穿件￥20.00" selectedRightTitle:@"秀试穿件￥20.00"];
        [button addTarget:self action:@selector(selectionAction2:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = mRGBToColor(0xfafafa);
        button.imageSize = CGSizeMake(RELATIVE_WIDTH(30), RELATIVE_WIDTH(30));
        [self.infoView addSubview:button];
        _selectionButton2 = button;
    }
    return _selectionButton2;
}

- (YYButton *)selectionButton3 {
    if (!_selectionButton3) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"秀全新件￥20.00" selectedRightTitle:@"秀全新件￥20.00"];
        button.imageSize = CGSizeMake(RELATIVE_WIDTH(30), RELATIVE_WIDTH(30));
        [button addTarget:self action:@selector(selectionAction3:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = mRGBToColor(0xfafafa);
        [self.infoView addSubview:button];
        _selectionButton3 = button;
    }
    return _selectionButton3;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"x1";
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self.infoView addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (UIView *)editeView {
    if (!_editeView) {
        UIView *view = [UIView new];
        view.backgroundColor = mRGBToColor(0xfafafa);
        view.hidden = YES;
        [self addSubview:view];
        _editeView = view;
    }
    return _editeView;
}


- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"+" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.borderColor = YYGrayTextColor.CGColor;
        button.layer.borderWidth = RELATIVE_WIDTH(1);
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.editeView addSubview:button];
        _addButton = button;
    }
    return _addButton;
}

- (UIButton *)minButton {
    if (!_minButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"-" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.borderColor = YYGrayTextColor.CGColor;
        button.layer.borderWidth = RELATIVE_WIDTH(1);
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [button addTarget:self action:@selector(minAction) forControlEvents:UIControlEventTouchUpInside];
        [self.editeView  addSubview:button];
        _minButton = button;
    }
    return _minButton;
}

- (UILabel *)editedCountLabel {
    if (!_editedCountLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.borderColor = YYGrayTextColor.CGColor;
        label.layer.borderWidth = RELATIVE_WIDTH(1);
        label.layer.masksToBounds = YES;
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"1";
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [self.editeView  addSubview:label];
        _editedCountLabel = label;
    }
    return _editedCountLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.textColor = YYGrayTextColor;
        label.layer.borderWidth = RELATIVE_WIDTH(1);
        label.layer.borderColor = YYGrayTextColor.CGColor;
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.masksToBounds = YES;
        label.text = @" S";
        [self.editeView  addSubview:label];
        _typeLabel = label;
    }
    return _typeLabel;
}

- (UIView *)tapView {
    if (!_tapView) {
        UIView *view = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [view addGestureRecognizer:tap];
        [self.typeLabel addSubview:view];
        _tapView = view;
    }
    return _tapView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_down"]];
        [self.typeLabel addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UIButton *)finishButton {
    if (!_finishButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setTitleColor:mRGBToColor(0xfafafa) forState:UIControlStateNormal];
        button.backgroundColor = mRGBToColor(0xf46060);
        [button addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
        [self.editeView addSubview:button];
        _finishButton = button;
    }
    return _finishButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self editeView];
        [self addButton];
        [self minButton];
        [self editedCountLabel];
        [self imgView];
        [self tapView];
        [self finishButton];
        
        [self infoView];
        [self nameLabel];
        [self colorLabel];
        [self marketPriceLabel];
        [self sizeLabel];
        [self discountLabel];
        [self tipLabel];
        [self selectionButton1];
        [self selectionButton2];
        [self selectionButton3];
        [self countLabel];
        _count = 1;
        
        WS(ws);
        
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoView).offset(RELATIVE_WIDTH(28));
            make.left.equalTo(self.infoView).offset(RELATIVE_WIDTH(10));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(32)));
        }];
        
        [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
            make.left.equalTo(self.nameLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(28)));
        }];
        
        [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.colorLabel.mas_right).offset(RELATIVE_WIDTH(4));
            make.top.equalTo(self.colorLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(220), RELATIVE_WIDTH(28)));
        }];
        
        [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.colorLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
            make.left.width.height.equalTo(self.nameLabel);
        }];
        
        [self.discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sizeLabel);
            make.left.height.mas_equalTo(self.marketPriceLabel);
            make.width.mas_equalTo(RELATIVE_WIDTH(280));
        }];
        
        [self.editeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.infoView).offset(-RELATIVE_WIDTH(20));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.top.equalTo(self.infoView).offset(RELATIVE_WIDTH(30));
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.editeButton.mas_bottom).offset(RELATIVE_WIDTH(134));
            make.right.equalTo(self.infoView).offset(-RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(40), RELATIVE_WIDTH(30)));
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sizeLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
            make.left.equalTo(self.infoView).offset(RELATIVE_WIDTH(10));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(350), RELATIVE_WIDTH(26)));
        }];
        
        [self.selectionButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipLabel.mas_bottom).offset(RELATIVE_WIDTH(12));
            make.left.equalTo(self.infoView).offset(RELATIVE_WIDTH(10));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(42)));
        }];
        
        [self.selectionButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectionButton1.mas_bottom).offset(RELATIVE_WIDTH(12));
            make.left.equalTo(self.infoView).offset(RELATIVE_WIDTH(10));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(42)));
        }];
        
        [self.selectionButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectionButton2.mas_bottom).offset(RELATIVE_WIDTH(12));
            make.left.equalTo(self.infoView).offset(RELATIVE_WIDTH(10));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(42)));
        }];
        
        [self.editeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        
        [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.editeView);
            make.width.mas_equalTo(RELATIVE_WIDTH(120));
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.finishButton.mas_left).offset(-RELATIVE_WIDTH(36));
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(170));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(294), RELATIVE_WIDTH(44)));
        }];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.typeLabel);
            make.right.equalTo(self.typeLabel).offset(-RELATIVE_WIDTH(8));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(30));
        }];
        
        [self.editedCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.typeLabel.mas_top).offset(-RELATIVE_WIDTH(26));
            make.centerX.equalTo(self.typeLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(190), RELATIVE_WIDTH(44)));
        }];
        
        [self.minButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.editedCountLabel.mas_left).offset(-RELATIVE_WIDTH(8));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.bottom.equalTo(self.editedCountLabel);
        }];
        
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.editedCountLabel.mas_right).offset(RELATIVE_WIDTH(8));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.bottom.equalTo(self.editedCountLabel);
        }];
    }
    return self;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.nameLabel.text = goodsModel.name;
}

#pragma mark - info action
- (void)selectionAction1:(UIButton *)sender
{
    if (self.selectionButton2.isSelected) {
        self.selectionButton2.selected = NO;
    }
    
    if (self.selectionButton3.isSelected) {
        self.selectionButton3.selected = NO;
    }
    
    sender.selected = !sender.isSelected;
}

- (void)selectionAction2:(UIButton *)sender
{
    if (self.selectionButton3.isSelected) {
        self.selectionButton3.selected = NO;
    }
    
    if (self.selectionButton1.isSelected) {
        self.selectionButton1.selected = NO;
    }
    
    sender.selected = !sender.isSelected;
}

- (void)selectionAction3:(UIButton *)sender
{
    if (self.selectionButton2.isSelected) {
        self.selectionButton2.selected = NO;
    }
    
    if (self.selectionButton1.isSelected) {
        self.selectionButton1.selected = NO;
    }
    
    sender.selected = !sender.isSelected;
}

- (void)editeAction
{
    self.editeView.hidden = NO;
    self.infoView.hidden = YES;
}

#pragma mark - edite action
- (void)addAction
{
    if (_count == 99) {
        return;
    }
    _count ++;
    self.editedCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_count];
    self.countLabel.text = [NSString stringWithFormat:@"x%ld", (long)_count];
}

- (void)minAction
{
    if (_count == 1) {
        return;
    }
    _count --;
    self.editedCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_count];
    self.countLabel.text = [NSString stringWithFormat:@"x%ld", (long)_count];
}

- (void)selectAction
{
    
}

- (void)tapAction
{
    
}

- (void)finishAction
{
    self.editeView.hidden = YES;
    self.infoView.hidden = NO;
}



@end
