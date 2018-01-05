//
//  YYBottomSelectView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBottomSelectView.h"
#import "YYSelectReturnRecieveTypeView.h"
#import "YYDatePickerView.h"

#define selectReturnRecieveTypeViewHeight RELATIVE_WIDTH(340)
#define selectDateTimeViewHeight RELATIVE_WIDTH(400)
@interface YYBottomSelectView ()
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIView *functionView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) YYSelectReturnRecieveTypeView *selectReturnRecieveView;
@property (nonatomic, weak) YYDatePickerView *selectDateView;

@end

@implementation YYBottomSelectView

{
    YYBottomSelectViewType _type;
    YYMineFunctionType _returnDeliveryType;
    NSString *_date;
    NSString *_time;
    NSString *_birthDay;
    CGFloat _functionViewHeight;
}

- (UIView *)containerView {
    if (!_containerView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _containerView = view;
    }
    return _containerView;
}

- (UIView *)functionView {
    if (!_functionView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(100))];
        view.backgroundColor = YYSeparatorColor;
        [self.containerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.containerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        _functionView = view;
    }
    return _functionView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [self.functionView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.functionView).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(self.functionView);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        _cancelButton = button;
    }
    return _cancelButton;
}

- (UIView *)backView {
    if (!_backView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        WS(ws);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.bottom.equalTo(self.containerView.mas_top);
        }];
        _backView = view;
    }
    return _backView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateDisabled];
        [button setTitleColor:YYGlobalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        button.enabled = NO;
        [self.functionView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.functionView).offset(-RELATIVE_WIDTH(24));
            make.centerY.equalTo(self.functionView);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        _sureButton = button;
    }
    return _sureButton;
}

- (YYSelectReturnRecieveTypeView *)selectReturnRecieveView {
    if (!_selectReturnRecieveView) {
        YYSelectReturnRecieveTypeView *view = [[YYSelectReturnRecieveTypeView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(240))];
        [self.containerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(240));
            make.bottom.equalTo(self.containerView).offset(iPhone_MARGIN_BOTTOM);
        }];
        _selectReturnRecieveView = view;
    }
    return _selectReturnRecieveView;
}


- (YYDatePickerView *)selectDateView {
    if (!_selectDateView) {
        YYDatePickerView *selectDateView = [[YYDatePickerView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(240))];
        [self.containerView addSubview:selectDateView];
        [selectDateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(300));
            make.bottom.equalTo(self.containerView).offset(-iPhone_MARGIN_BOTTOM);
        }];
        _selectDateView = selectDateView;
    }
    return _selectDateView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT);
        self.containerView.frame = CGRectMake(0, WIN_HEIGHT, self.mj_w, self.mj_h);
        [self functionView];
        [self cancelButton];
        [self sureButton];
        [self backView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(YYBottomSelectViewType)type
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT);
        _type = type;
        CGFloat height = 0.0;
        switch (type) {
            case YYBottomSelectViewTypeDelviery:
            case YYBottomSelectViewTypeRecieve:
                height = selectReturnRecieveTypeViewHeight + iPhone_MARGIN_BOTTOM;
                break;
            case YYBottomSelectViewTypeDateTime:
            case YYBottomSelectViewTypeBirthDay:
            case YYBottomSelectViewTypeReturnDateTime:
                height = selectDateTimeViewHeight + iPhone_MARGIN_BOTTOM;
                break;
            default:
                break;
        }
        self.containerView.frame = CGRectMake(0, WIN_HEIGHT, self.mj_w, height);
        [self functionView];
        [self cancelButton];
        [self sureButton];
        [self backView];
        switch (type) {
            case YYBottomSelectViewTypeDelviery:
            case YYBottomSelectViewTypeRecieve:
            {
                self.selectReturnRecieveView.type = _type == YYBottomSelectViewTypeRecieve ? YYSelectReturnRecieveViewTypeReturn : YYSelectReturnRecieveViewTypeDelivery;
                self.selectReturnRecieveView.didSelectType = ^(YYMineFunctionType type) {
                    self.sureButton.enabled = YES;
                    _returnDeliveryType = type;
                };
                break;
            }
            case YYBottomSelectViewTypeDateTime:
            {
                self.selectDateView.type = YYDatePickerViewTypeYearMonthDayTimeDuration;
                self.selectDateView.didSelectDateAndTimeBlock = ^(NSString *date, NSString *time) {
                    self.sureButton.enabled = YES;
                    _date = date;
                    _time = time;
                };
                [self.selectDateView selectDefaultDate];
                break;
            }
            case YYBottomSelectViewTypeBirthDay:
            {
                self.selectDateView.type = YYDatePickerViewTypeBirthDay;
                self.selectDateView.didSelectBirthDayBlock = ^(NSString *birthDay) {
                    self.sureButton.enabled = YES;
                    _birthDay = birthDay;
                };
                break;
            }
            case YYBottomSelectViewTypeReturnDateTime:
            {
                self.selectDateView.type = YYDatePickerViewTypeReturnDate;
                self.selectDateView.didSelectDateAndTimeBlock = ^(NSString *date, NSString *time) {
                    self.sureButton.enabled = YES;
                    _date = date;
                    _time = time;
                };
                [self.selectDateView selectDefaultDate];
            }
                break;
            default:
                break;
        }
    }
    return self;
}



- (void)sureAction
{
    switch (_type) {
        case YYBottomSelectViewTypeDateTime:
        case YYBottomSelectViewTypeReturnDateTime:
            if (_didSelectDateAndTimeBlock) {
                _didSelectDateAndTimeBlock(_date, _time);
            }
            break;
        case YYBottomSelectViewTypeBirthDay:
            if (_didSelectBirthDayBlock) {
                _didSelectBirthDayBlock(_birthDay);
            }
            break;
        case YYBottomSelectViewTypeRecieve:
        case YYBottomSelectViewTypeDelviery:
            if (_didFinishSelectBlock) {
                _didFinishSelectBlock(_returnDeliveryType);
            }
            break;
        default:
            break;
    }
    [self hide];
}

- (void)cancelAction
{
    [self hide];
}

- (void)hide
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:.5 animations:^{
        self.containerView.mj_y = WIN_HEIGHT;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperview];
    });
}

- (void)show
{
    [(mAppDelegate).window addSubview:self];
    CGFloat y = 0.0;
    switch (_type) {
        case YYBottomSelectViewTypeRecieve:
        case YYBottomSelectViewTypeDelviery:
            y = WIN_HEIGHT - selectReturnRecieveTypeViewHeight - iPhone_MARGIN_BOTTOM;
            break;
        case YYBottomSelectViewTypeDateTime:
        case YYBottomSelectViewTypeBirthDay:
        case YYBottomSelectViewTypeReturnDateTime:
            y = WIN_HEIGHT - selectDateTimeViewHeight - iPhone_MARGIN_BOTTOM;
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.mj_y = y;
    }];
}

@end
