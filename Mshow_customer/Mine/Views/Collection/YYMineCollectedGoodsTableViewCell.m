//
//  YYMineCollectedGoodsTableViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCollectedGoodsTableViewCell.h"
#import "YYGoodsTableCellTypeView.h"
#import "YYGoodsModel.h"

@interface YYMineCollectedGoodsTableViewCell ()
@property (nonatomic, weak) YYGoodsTableCellTypeView *goodsView;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation YYMineCollectedGoodsTableViewCell

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self.contentView addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        YYGoodsTableCellTypeView *view = [[YYGoodsTableCellTypeView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(222))];
        [self.contentView addSubview:view];
        _goodsView = view;
    }
    return self;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.goodsView.goodsModel = goodsModel;
    self.goodsView.buttonActionBlock = ^{
        if (!_isEditing) {
            if (_showShopDetailBlock) {
                _showShopDetailBlock(_goodsModel.shop_id);
            }
        }
    };
    if (_isEditing) {
        self.selectButton.selected = goodsModel.isSelected;
    }
}

- (void)selectButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    _goodsModel.isSelected = sender.isSelected;
    if (_selectGoodsBlock) {
        _selectGoodsBlock(_goodsModel);
    }
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    WS(ws);
    if (isEditing) {
        self.selectButton.hidden = NO;
        [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws.contentView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        [self.goodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectButton.mas_right);
            make.bottom.top.right.equalTo(ws.contentView);
        }];
    } else {
        self.selectButton.hidden = YES;
        [self.goodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
    }
}

@end
