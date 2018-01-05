//
//  YYAppealDealView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYAppealDealView.h"
#import "YYTextView.h"
#import "YYDealModel.h"

@interface YYAppealDealView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) YYTextView *commentTextView;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *sureButton;

@end

@implementation YYAppealDealView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.text = @"申诉原因";
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"提交" forState:UIControlStateNormal];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.backgroundColor = YYDisableColor;
        button.enabled = NO;
        [self addSubview:button];
        _sureButton = button;
    }
    return _sureButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = YYDisableColor.CGColor;
        button.layer.borderWidth = RELATIVE_WIDTH(2);
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [self addSubview:button];
        _cancelButton = button;
    }
    return _cancelButton;
}

- (YYTextView *)commentTextView {
    if (!_commentTextView) {
        YYTextView *view = [[YYTextView alloc] init];
        view.backgroundColor = mRGBToColor(0xf6f6f6);
        [view setPlaceHolder:@"请填写申诉原因" placeHolderTextColor:YYPlaceHolderColor];
        view.maxTextCount = 140;
        view.numLabelText = @"还可输入140个字";
        view.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self addSubview:view];
        _commentTextView = view;
    }
    return _commentTextView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        self.commentTextView.textDidChangeBlock = ^(CGSize textSize, NSString *text) {
            StrongSelf(strongSelf);
            strongSelf = ws;
            strongSelf.sureButton.enabled = [text isValid];
            strongSelf.sureButton.backgroundColor = [text isValid] ? YYGlobalColor : YYDisableColor;
        };
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(38));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(36));
        }];
        
        [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(400));
        }];
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(114));
            make.top.equalTo(self.commentTextView.mas_bottom).offset(RELATIVE_WIDTH(60));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(60)));
        }];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(114));
            make.top.equalTo(self.commentTextView.mas_bottom).offset(RELATIVE_WIDTH(60));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(60)));
        }];
    }
    return self;
}

- (void)cancelAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeCancelAction)]) {
        [_delegate executeCancelAction];
    }
}

- (void)sureAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeSureAction:)]) {
        [_delegate executeSureAction:_dealModel];
    }
}


@end
