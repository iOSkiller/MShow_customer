//
//  YYTotalCommentView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYTotalCommentView.h"
#import "YYTextView.h"
#import "YYCommentScoreView.h"
#import "YYCommentDefectSeletionView.h"
#import "YYDefectModel.h"

@interface YYTotalCommentView ()
@property (nonatomic, weak) YYTextView *suggestionTextView;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) YYCommentScoreView *scoreView;
@property (nonatomic, weak) YYCommentDefectSeletionView *selectionView;
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIView *line2;

@end

@implementation YYTotalCommentView

- (UIView *)line1 {
    if (!_line1) {
        UIView *line = [UIView new];
        line.backgroundColor = YYSeparatorColor;
        [self addSubview:line];
        _line1 = line;
    }
    return _line1;
}

- (UIView *)line2 {
    if (!_line2) {
        UIView *line = [UIView new];
        line.backgroundColor = YYSeparatorColor;
        [self addSubview:line];
        _line2 = line;
    }
    return _line2;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_all"]];
        [self addSubview:view];
        _iconView = view;
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"总评";
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (YYTextView *)suggestionTextView {
    if (!_suggestionTextView) {
        YYTextView *view = [[YYTextView alloc] init];
        [view setPlaceHolder:@"留言:有哪些地方我们能做得更好呢？" placeHolderTextColor:YYPlaceHolderColor];
        view.maxTextCount = 140;
        view.numLabelText = @"还可输入140个字";
        view.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _suggestionTextView = view;
    }
    return _suggestionTextView;
}

- (YYCommentScoreView *)scoreView {
    if (!_scoreView) {
        YYCommentScoreView *view = [[YYCommentScoreView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(240))];
        [self addSubview:view];
        _scoreView = view;
    }
    return _scoreView;
}

- (YYCommentDefectSeletionView *)selectionView {
    if (!_selectionView) {
        YYCommentDefectSeletionView *view = [[YYCommentDefectSeletionView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(560), RELATIVE_WIDTH(240))];
        view.backgroundColor = [UIColor whiteColor];
        view.hidden = YES;
        [self addSubview:view];
        _selectionView = view;
    }
    return _selectionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self iconView];
        [self titleLabel];
        [self suggestionTextView];
        [self line1];
        [self scoreView];
        [self selectionView];
        [self line2];
        
        WS(ws);
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(20));
            make.centerY.equalTo(self.iconView);
            make.width.greaterThanOrEqualTo(@0.0f);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
        }];
        
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(79));
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(240));
        }];
        
        [self.suggestionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(10));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(200));
        }];
        
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.suggestionTextView.mas_top);
            make.right.left.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        self.scoreView.didMarkBlock = ^(YYScoreType type, double score) {
            if (_changeMarkBlock) {
                _changeMarkBlock(score);
            }
            if (score < 0.7) {
                self.selectionView.hidden = NO;
                self.selectionView.selectionArray = [YYDefectModel testDataAarray];
                [self.selectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(ws);
                    make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(560), RELATIVE_WIDTH(240)));
                    make.top.equalTo(self.scoreView.mas_bottom);
                }];
                
            } else {
                self.selectionView.hidden = YES;
            }
        };
    }
    return self;
}

@end
