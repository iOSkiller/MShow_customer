//
//  YYGoodsDetailViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/7.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsDetailViewCell.h"
#import "YYGoodsInfoView.h"
#import "YYGoodsCommentView.h"
#import "YYCommentModel.h"
#import "YYGoodsNameView.h"

@interface YYGoodsDetailViewCell ()
@property (nonatomic, weak) YYGoodsInfoView *infoView;
@property (nonatomic, weak) YYGoodsCommentView *commentView;
@property (nonatomic, weak) YYGoodsNameView *goodsNameView;
@property (nonatomic, weak) UILabel *centerLabel;
@property (nonatomic, weak) UIImageView *arrowView;

@end

@implementation YYGoodsDetailViewCell

- (YYGoodsInfoView *)infoView {
    if (!_infoView) {
        YYGoodsInfoView *view = [[YYGoodsInfoView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132))];
        [self.contentView addSubview:view];
        _infoView = view;
    }
    return _infoView;
}

- (YYGoodsCommentView *)commentView {
    if (!_commentView) {
        YYGoodsCommentView *commentView = [[YYGoodsCommentView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:commentView];
        _commentView = commentView;
    }
    return _commentView;
}

- (YYGoodsNameView *)goodsNameView {
    if (!_goodsNameView) {
        YYGoodsNameView *view = [[YYGoodsNameView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        _goodsNameView = view;
    }
    return _goodsNameView;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
        [self.contentView addSubview:imgView];
        _arrowView = imgView;
    }
    return _arrowView;
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYGrayTextColor;
        label.text = @"查看全部评价";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _centerLabel = label;
    }
    return _centerLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = YYTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        self.detailTextLabel.textColor = mRGBToColor(0x757575);
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setCommentContentHeight:(CGFloat)commentContentHeight
{
    _commentContentHeight = commentContentHeight;
    self.commentView.contentHeight = commentContentHeight;
    self.commentView.canUpvote = NO;
}

- (void)setCommentModel:(YYCommentModel *)commentModel
{
    _commentModel = commentModel;
    self.commentView.commentModel = commentModel;
}

- (void)setName:(NSString *)name currentPrice:(NSString *)currentPrice originalPrice:(NSString *)originalPrice
{
    [self.goodsNameView setName:name currentPrice:currentPrice originalPrice:originalPrice];
}

- (void)setType:(YYGoodsDetailViewCellType)type
{
    _type = type;
    WS(ws);
    switch (type) {
        case YYGoodsDetailViewCellTypeName:
        {
            [self.goodsNameView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(ws.contentView);
            }];
            break;
        }
        case YYGoodsDetailViewCellTypeSelectSizeColor:
        {
            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
            view.frame = CGRectMake(0, 0, RELATIVE_WIDTH(30), RELATIVE_WIDTH(30));
            self.accessoryView = view;
            break;
        }
        case YYGoodsDetailViewCellTypeInfo:
        {
            [self infoView];
            [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(ws.contentView);
            }];
        }
            break;
        case YYGoodsDetailViewCellTypeComment:
        {
            [self commentView];
            [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(ws.contentView);
            }];
        }
            break;
        case YYGoodsDetailViewCellTypeCenterLabel:
        {
            [self centerLabel];
            [self arrowView];
            [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(ws.contentView);
            }];
            [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(ws.contentView);
                make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(468));
                make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(30), RELATIVE_WIDTH(30)));
            }];
        }
            break;
        case YYGoodsDetailViewCellTypeDefault:
            break;
    }
}

@end
