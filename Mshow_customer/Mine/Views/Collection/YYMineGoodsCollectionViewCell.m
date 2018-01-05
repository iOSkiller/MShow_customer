//
//  YYMineGoodsCollectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineGoodsCollectionViewCell.h"
#import "YYGoodsModel.h"

@interface YYMineGoodsCollectionViewCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *typeLabel;
@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation YYMineGoodsCollectionViewCell

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        label.text = @"欧根纱拼接连衣裙";
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGrayTextColor;
        label.text = @"XS S M L";
        [self.contentView addSubview:label];
        _typeLabel = label;
    }
    return _typeLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"img_deleting"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _deleteButton = button;
    }
    return _deleteButton;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self.contentView addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
        [self typeLabel];
        [self nameLabel];
        
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(450));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
        }];
    }
    return self;
}

- (void)deleteButtonAction
{
    if (_deleteActionBlock) {
        _deleteActionBlock(_goodsModel);
    }
}

- (void)selectButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_selectActionBlock) {
        _selectActionBlock(_goodsModel, sender.isSelected);
    }
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    WS(ws);
    if (_isEditing) {
        self.selectButton.hidden = NO;
        self.deleteButton.hidden = YES;
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(16));
            //        make.size.mas_equalTo(imgSize);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(28));
        }];
    } else {
        self.selectButton.hidden = YES;
        self.deleteButton.hidden = NO;
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(16));
            //        make.size.mas_equalTo(imgSize);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(28));
        }];
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.imgView performSelector:@selector(setImage:) withObject:[UIImage clipImage:[UIImage imageNamed:goodsModel.image] toRect:self.imgView.mj_size] afterDelay:0.2 inModes:@[NSDefaultRunLoopMode]];
    self.selectButton.selected = goodsModel.isSelected;
}

@end
