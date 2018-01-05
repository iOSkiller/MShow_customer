//
//  YYHistoryViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryViewCell.h"
#import "YYGoodsModel.h"

@interface YYHistoryViewCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIView *tapView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *typeLabel;
@property (nonatomic, weak) UIButton *likeButton;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation YYHistoryViewCell
- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor whiteColor];
        //        view.contentMode = UIViewContentModeScaleAspectFit;
        //        view.autoresizesSubviews = YES;
        //        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
//        [view addGestureRecognizer:longpress];
//        view.userInteractionEnabled = YES;
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}


- (UIView *)tapView {
    if (!_tapView) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = mRGBAColor(0, 0, 0, 0.7);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [view addGestureRecognizer:tap];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_deleting"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deletAction) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = mRGBAColor(0, 0, 0, 0.7);
        button.center = view.center;
        button.bounds = CGRectMake(0, 0, RELATIVE_WIDTH(88), RELATIVE_WIDTH(88));
        [view addSubview:button];
        view.hidden = YES;
        [self.contentView addSubview:view];
        _tapView = view;
    }
    return _tapView;
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

- (UIButton *)likeButton {
    if (!_likeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"choose_btn_collect_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn_collect_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _likeButton = button;
    }
    return _likeButton;
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
        [self nameLabel];
        [self typeLabel];
//        [self tapView];
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

- (void)longPressAction
{
    self.tapView.hidden = NO;
}

- (void)deletAction
{
    if (_deletActionBlock) {
        _deletActionBlock(_goodsModel);
    }
}

- (void)tapAction
{
    self.tapView.hidden = YES;
}


- (void)likeButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_likeActionBlock) {
        _likeActionBlock(_goodsModel, sender.selected);
    }
}

- (void)selectButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_selectActionBlock) {
        _selectActionBlock(_goodsModel, sender.selected);
    }
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    WS(ws);
    if (_isEditing) {
        self.selectButton.hidden = NO;
        self.likeButton.hidden = YES;
        [self.likeButton removeFromSuperview];
        [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(16));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(28));
        }];
    } else {
        self.selectButton.hidden = YES;
        [self.selectButton removeFromSuperview];
        self.likeButton.hidden = NO;
        [self.likeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(16));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(28));
        }];
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.imgView performSelector:@selector(setImage:) withObject:[UIImage clipImage:[UIImage imageNamed:goodsModel.image] toRect:self.imgView.mj_size] afterDelay:0.2 inModes:@[NSDefaultRunLoopMode]];
//    self.nameLabel.text = goodsModel.name;
    self.selectButton.selected = goodsModel.isSelected;
}

@end
