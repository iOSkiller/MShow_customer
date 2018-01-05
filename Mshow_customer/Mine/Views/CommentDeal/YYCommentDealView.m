//
//  YYCommentDealView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentDealView.h"
#import "YYCommentSelectImageView.h"
#import "YYTextView.h"
#import "YYButton.h"
#import "YYTotalCommentView.h"
#import "YYDefectModel.h"
#import "YYCommentModel.h"

@interface YYCommentDealView ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) YYCommentSelectImageView *selectImageView;
@property (nonatomic, weak) YYTextView *commentTextView;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) YYButton *anonymousButton;
@property (nonatomic, weak) YYButton *sizeButton;
@property (nonatomic, weak) UIButton *submitButton;
@property (nonatomic, weak) YYTotalCommentView *totalCommentView;
@property (nonatomic, weak) UIView *buttonBackView;
@property (nonatomic, weak) UIView *separatorView;
@end

@implementation YYCommentDealView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h - RELATIVE_WIDTH(200))];
        view.showsVerticalScrollIndicator = NO;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _scrollView = view;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:view];
        _contentView = view;
    }
    return _contentView;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        UIView *view = [UIView new];
        view.backgroundColor = YYSeparatorColor;
        [self.contentView addSubview:view];
        _separatorView = view;
    }
    return _separatorView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = YYGlobalColor;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        [button setTitle:@"提交评价领取积分" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.enabled = NO;
        button.backgroundColor = YYDisableColor;
        [button addTarget:self action:@selector(sumbitAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _submitButton = button;
    }
    return _submitButton;
}

- (YYTextView *)commentTextView {
    if (!_commentTextView) {
        YYTextView *view = [[YYTextView alloc] init];
        [view setPlaceHolder:@"您的评价对我们非常宝贵哦" placeHolderTextColor:YYPlaceHolderColor];
        view.maxTextCount = 140;
        view.numLabelText = @"还可输入140个字";
        view.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _commentTextView = view;
    }
    return _commentTextView;
}

- (YYCommentSelectImageView *)selectImageView {
    if (!_selectImageView) {
        YYCommentSelectImageView *view = [[YYCommentSelectImageView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(200))];
        view.maxImagesCount = 3;
        [self.contentView addSubview:view];
        _selectImageView = view;
    }
    return _selectImageView;
}

- (UIView *)line {
    if (!_line) {
        UIView *view = [UIView new];
        view.backgroundColor = YYSeparatorColor;
        [self.contentView addSubview:view];
        _line = view;
    }
    return _line;
}

- (UIView *)buttonBackView {
    if (!_buttonBackView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.contentView addSubview:view];
        _buttonBackView = view;
    }
    return _buttonBackView;
}

- (YYButton *)anonymousButton {
    if (!_anonymousButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"匿名" selectedRightTitle:nil];
        button.normalColor = YYTextColor;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(anonymousAction) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonBackView addSubview:button];
        _anonymousButton = button;
    }
    return _anonymousButton;
}

- (YYButton *)sizeButton {
    if (!_sizeButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"隐藏我的尺码" selectedRightTitle:nil];
        button.normalColor = YYTextColor;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(sizeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonBackView addSubview:button];
        _sizeButton = button;
    }
    return _sizeButton;
}

- (YYTotalCommentView *)totalCommentView {
    if (!_totalCommentView) {
        YYTotalCommentView *view = [[YYTotalCommentView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(664))];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _totalCommentView = view;
    }
    return _totalCommentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self scrollView];
        [self contentView];
        [self commentTextView];
        [self separatorView];
        [self line];
        [self anonymousButton];
        [self sizeButton];
        [self submitButton];
        [self totalCommentView];
        
        WS(weakSelf);
        self.commentTextView.textDidChangeBlock = ^(CGSize textSize, NSString *text) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            strongSelf.submitButton.enabled = [text isValid];
            strongSelf.submitButton.backgroundColor = [text isValid] ? YYGlobalColor : YYDisableColor;
        };
        
        self.selectImageView.pickImageBlock = ^(NSInteger imagesCount) {
            if (_delegate && [_delegate respondsToSelector:@selector(executePickImage:)]) {
                [_delegate executePickImage:imagesCount];
            }
        };
        
        self.selectImageView.showImageBlock = ^(UIImage *image, NSUInteger index) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowImage:index:)]) {
                [_delegate executeShowImage:image index:index];
            }
        };
        
        self.selectImageView.didChangeImage = ^(NSArray *imageArray) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            strongSelf.imageArray = imageArray;
            if (_delegate && [_delegate respondsToSelector:@selector(executeChangeImage:)]) {
                [_delegate executeChangeImage:imageArray];
            }
        };
        
        self.totalCommentView.changeMarkBlock = ^(double score) {
            [self.totalCommentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(score < 0.7 ? RELATIVE_WIDTH(780) : RELATIVE_WIDTH(540));
            }];
            [self setNeedsUpdateConstraints];
            [self updateConstraintsIfNeeded];
            
            [UIView animateWithDuration:0.5 animations:^{
                [self layoutIfNeeded];
            }];
        };
        
        self.backgroundColor = YYSeparatorColor;
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf).offset(-RELATIVE_WIDTH(200));
            make.top.left.right.equalTo(weakSelf);
            
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView);
            make.width.equalTo(_scrollView);
            make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
        }];
        
        [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(RELATIVE_WIDTH(28));
            make.left.equalTo(self.contentView).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(self.contentView).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(320));
        }];
        
        [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentTextView.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(200));
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectImageView.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        
//        CGFloat buttonWidth = (self.mj_w - RELATIVE_WIDTH(48) - RELATIVE_WIDTH(10)) / 2;
        [self.anonymousButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.buttonBackView).offset(RELATIVE_WIDTH(30));
            make.left.equalTo(self.contentView).offset(RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(110), RELATIVE_WIDTH(46)));
        }];
        
        [self.sizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-RELATIVE_WIDTH(24));
            make.top.height.equalTo(self.anonymousButton);
            make.width.mas_equalTo(RELATIVE_WIDTH(230));
        }];
        
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(10));
        }];
        
        [self.totalCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.buttonBackView.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(540));
            //自适应
            make.bottom.equalTo(self.contentView);
        }];
        
        [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf).offset(-RELATIVE_WIDTH(60));
            make.left.equalTo(weakSelf).offset(RELATIVE_WIDTH(20));
            make.right.equalTo(weakSelf).offset(-RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    self.selectImageView.imageArray = imageArray;
}

#pragma mark - button action
- (void)sumbitAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeSubmietComment:)]) {
        [_delegate executeSubmietComment:_commentModel];
    }
}

- (void)anonymousAction
{
    self.anonymousButton.selected = !self.anonymousButton.isSelected;
}

- (void)sizeAction
{
    self.sizeButton.selected = !self.sizeButton.isSelected;
}


@end
