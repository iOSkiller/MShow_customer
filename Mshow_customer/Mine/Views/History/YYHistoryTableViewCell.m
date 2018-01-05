//
//  YYHistoryTableViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryTableViewCell.h"
#import "YYGoodsTableCellTypeView.h"
#import "YYHistoryTableViewCellFunctionView.h"
#import "YYGoodsModel.h"

@interface YYHistoryTableViewCell ()
@property (nonatomic, weak) YYGoodsTableCellTypeView *goodsView;
@property (nonatomic, weak) YYHistoryTableViewCellFunctionView *functionView;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation YYHistoryTableViewCell

- (YYGoodsTableCellTypeView *)goodsView {
    if (!_goodsView) {
        YYGoodsTableCellTypeView *view = [[YYGoodsTableCellTypeView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(222))];
        [self.contentView addSubview:view];
        _goodsView = view;
    }
    return _goodsView;
}

- (YYHistoryTableViewCellFunctionView *)functionView {
    if (!_functionView) {
        YYHistoryTableViewCellFunctionView *view = [[YYHistoryTableViewCellFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(60))];
        [self.contentView addSubview:view];
        _functionView = view;
    }
    return _functionView;
}

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
    }
    return self;
}

- (void)setIsAllSelected:(BOOL)isAllSelected
{
    _isAllSelected = isAllSelected;
    self.functionView.isSelected = isAllSelected;
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    
    switch (_type) {
        case YYHistoryTableViewCellTypeFunction:
            self.functionView.isEditing = isEditing;
            break;
        case YYHistoryTableViewCellTypeGoods:
        {
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
            break;
        default:
            break;
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.goodsView.goodsModel = goodsModel;
    if (!self.selectButton.hidden) {
        self.selectButton.selected = goodsModel.isSelected;
    }
}

- (void)setDate:(NSString *)date
{
    _date = date;
    self.functionView.date = date;
}

- (void)setType:(YYHistoryTableViewCellType)type
{
    _type = type;
    switch (type) {
        case YYHistoryTableViewCellTypeGoods:
        {
            self.goodsView.buttonActionBlock = ^{
                if (!_isEditing) {
                    if (_showShopDetailBlock) {
                        _showShopDetailBlock(_goodsModel.shop_id);
                    }
                }
            };
        }
            break;
        case YYHistoryTableViewCellTypeFunction:
        {
            self.contentView.backgroundColor = mRGBToColor(0xf0f0f0);
            self.functionView.selectBlock = ^(BOOL isSelected) {
                if (_selectAllGoodsBlock) {
                    _selectAllGoodsBlock(isSelected);
                }
            };
        }
            break;
        default:
            break;
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

@end
