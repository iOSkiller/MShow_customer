//
//  YYMineCommentViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCommentViewCell.h"
#import "YYMineWardrobeGoodsView.h"
#import "YYCommentModel.h"

@interface YYMineCommentViewCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nickNameLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UIButton *commentButton;
@property (nonatomic, weak) UIButton *upvoteButton;
@property (nonatomic, weak) UIButton *lookButton;
@property (nonatomic, weak) UIButton *editeButton;
@property (nonatomic, weak) YYMineWardrobeGoodsView *goodsView;

@end

@implementation YYMineCommentViewCell

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *view = [UIImageView new];
        view.layer.cornerRadius = RELATIVE_WIDTH(32);
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        view.image = [UIImage imageNamed:@"login_logo"];
        [self.contentView addSubview:view];
        _iconView = view;
    }
    return _iconView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"喵喵喵喵";
        [self.contentView addSubview:label];
        _nickNameLabel = label;
    }
    return _nickNameLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.text = @"10月21日";
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.backgroundColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (YYMineWardrobeGoodsView *)goodsView {
    if (!_goodsView) {
        YYMineWardrobeGoodsView *view = [[YYMineWardrobeGoodsView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(236))];
        view.showCount = NO;
        [self.contentView addSubview:view];
        _goodsView = view;
    }
    return _goodsView;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_message"] forState:UIControlStateNormal];
        [button setTitle:@"20" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [button addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _commentButton = button;
    }
    return _commentButton;
}

- (UIButton *)upvoteButton {
    if (!_upvoteButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_good_pre"] forState:UIControlStateNormal];
        [button setTitle:@"20" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [button addTarget:self action:@selector(upvoteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _upvoteButton = button;
    }
    return _upvoteButton;
}

- (UIButton *)lookButton {
    if (!_lookButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_see"] forState:UIControlStateNormal];
        [button setTitle:@"20" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [button addTarget:self action:@selector(lookAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _lookButton = button;
    }
    return _lookButton;
}

- (UIButton *)editeButton {
    if (!_editeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_modification"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(editeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _editeButton = button;
    }
    return _editeButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setContentHeight:(CGFloat)contentHeight
{
    WS(ws);
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(30));
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
        make.width.height.mas_equalTo(RELATIVE_WIDTH(64));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
        make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(20));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(28)));
    }];
     
     [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(20));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(28)));
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
     }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(RELATIVE_WIDTH(20));
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(30));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(120));
        make.height.mas_equalTo(contentHeight);
    }];
    
    [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(RELATIVE_WIDTH(2));
        make.left.right.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(236));
    }];
    
    CGFloat width = (self.mj_w - RELATIVE_WIDTH(90) * 4) / 3;
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
        make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(50)));
        make.left.mas_equalTo(ws.contentView).offset(RELATIVE_WIDTH(90));
    }];
    
    [self.upvoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(self.commentButton);
        make.centerX.equalTo(ws.contentView);
    }];
    
    [self.lookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView).offset(-RELATIVE_WIDTH(90));
        make.bottom.width.height.equalTo(self.commentButton);
    }];
    
    [self.editeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
        make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
    }];
    
}

#pragma mark - button action
- (void)commentAction
{
    if (_showCommentBlock) {
        _showCommentBlock(_commentModel);
    }
}

- (void)upvoteAction
{
    
}

- (void)lookAction
{
    
}

- (void)editeAction
{
    if (_editeActionBlock) {
        _editeActionBlock(_commentModel);
    }
}

- (void)setCommentModel:(YYCommentModel *)commentModel
{
    _commentModel = commentModel;
    self.contentLabel.text = commentModel.content;
    self.goodsView.goodsModel = commentModel.goodsModel;
    _goodsModel = commentModel.goodsModel;
}


@end
