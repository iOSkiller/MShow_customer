//
//  YYReturnGoodsViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYReturnGoodsViewCell.h"
#import "YYMineWardrobeGoodsView.h"
#import "YYGoodsModel.h"

@interface YYReturnGoodsViewCell ()
@property (nonatomic, weak) YYMineWardrobeGoodsView *goodsView;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation YYReturnGoodsViewCell

- (YYMineWardrobeGoodsView *)goodsView {
    if (!_goodsView) {
        YYMineWardrobeGoodsView *view = [[YYMineWardrobeGoodsView alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(68), 0, WIN_WIDTH - RELATIVE_WIDTH(68), RELATIVE_WIDTH(236))];
        view.backgroundColor = [UIColor whiteColor];
        for (UIView *subview in view.subviews) {
            subview.backgroundColor = [UIColor whiteColor];
        }
        [self.contentView addSubview:view];
        _goodsView = view;
    }
    return _goodsView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WS(ws);
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.centerY.equalTo(ws.contentView);
        }];
        
        [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectButton.mas_right);
            make.right.equalTo(ws.contentView);
            make.top.bottom.equalTo(ws.contentView);
        }];
    }
    return self;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.goodsView.goodsModel = goodsModel;
    self.selectButton.selected = goodsModel.isSelected;
}

- (void)selectButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    _goodsModel.isSelected = sender.isSelected;
    if (_selectBlock) {
        _selectBlock(_goodsModel);
    }
}

@end
