//
//  YYCommentSuccessView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/21.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentSuccessView.h"
#import "YYGussessLikeView.h"
#import "YYGoodsModel.h"

@interface YYCommentSuccessView ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) YYGussessLikeView *likeView;

@end


@implementation YYCommentSuccessView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *view = [[UIScrollView alloc] initWithFrame:self.bounds];
        view.showsVerticalScrollIndicator = NO;
        [self addSubview:view];
        _scrollView = view;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = YYSeparatorColor;
        [self.scrollView addSubview:view];
        _contentView = view;
    }
    return _contentView;
}


- (YYGussessLikeView *)likeView {
    if (!_likeView) {
        YYGussessLikeView *likeView = [[YYGussessLikeView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(1080))];
        [self.contentView addSubview:likeView];
        _likeView = likeView;
    }
    return _likeView;
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(350))];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"谢谢亲的评价，您的评价对我们帮助很大";
        label.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"查看我的评价" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.top.equalTo(view).offset(RELATIVE_WIDTH(60));
            make.height.mas_equalTo(RELATIVE_WIDTH(40));
            make.width.greaterThanOrEqualTo(@0.0f);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.top.equalTo(label.mas_bottom).offset(RELATIVE_WIDTH(60));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(60)));
        }];
        
        [self.contentView addSubview:view];
        _headerView = view;
    }
    return _headerView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self scrollView];
        [self contentView];
        [self likeView];
        [self headerView];
        
        self.likeView.showGoodsBlock = ^(YYGoodsModel *goodsModel) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoods:)]) {
                [_delegate executeShowGoods:goodsModel];
            }
        };
        
        
    }
    return self;
}

- (void)setLikeArray:(NSArray *)likeArray
{
    _likeArray = likeArray;
    self.likeView.likeGoodsArray = likeArray;
    
    
    WS(ws);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(RELATIVE_WIDTH(350));
    }];
    
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(RELATIVE_WIDTH(10));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(RELATIVE_WIDTH(1750));
        make.bottom.equalTo(self.contentView);
    }];
    
}

- (void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowMyComment)]) {
        [_delegate executeShowMyComment];
    }
}

@end
