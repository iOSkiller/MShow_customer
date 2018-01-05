//
//  YYWalletQuestionDetailView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/21.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWalletQuestionDetailView.h"
#import "YYQuestionModel.h"

@interface YYWalletQuestionDetailView ()
@property (nonatomic, weak) UILabel *questionLabel;
@property (nonatomic, weak) UILabel *questionTagView;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UILabel *contentTagView;
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation YYWalletQuestionDetailView

- (UILabel *)questionTagView {
    if (!_questionTagView) {
        UILabel *label = [UILabel new];
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.masksToBounds = YES;
        label.backgroundColor = YYGlobalColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = [UIColor whiteColor];
        label.text = @"Q";
        [self addSubview:label];
        _questionTagView = label;
    }
    return _questionTagView;
}

- (UILabel *)questionLabel {
    if (!_questionLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.numberOfLines = 0;
        [self addSubview:label];
        _questionLabel = label;
    }
    return _questionLabel;
}

- (UILabel *)contentTagView {
    if (!_contentTagView) {
        UILabel *label = [UILabel new];
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.masksToBounds = YES;
        label.backgroundColor = YYGlobalColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = [UIColor whiteColor];
        label.text = @"A";
        [self addSubview:label];
        _contentTagView = label;
    }
    return _contentTagView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.numberOfLines = 0;
        [self addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIView *)line {
    if (!_line) {
        UIView *view = [UIView new];
        view.backgroundColor = YYSeparatorColor;
        [self addSubview:view];
        _line = view;
    }
    return _line;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        [self.questionTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(34));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(36), RELATIVE_WIDTH(36)));
        }];
        
        [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.questionTagView.mas_right).offset(RELATIVE_WIDTH(10));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(34));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(36)));
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.questionLabel.mas_bottom).offset(RELATIVE_WIDTH(34));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.contentTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(34));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(36), RELATIVE_WIDTH(36)));
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentTagView.mas_right).offset(RELATIVE_WIDTH(10));
            make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(34));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(36)));
        }];
    }
    return self;
}

- (void)setQuestionModel:(YYQuestionModel *)questionModel
{
    _questionModel = questionModel;
    self.questionLabel.text = questionModel.question;
    self.contentLabel.text = questionModel.answer;
}

@end
