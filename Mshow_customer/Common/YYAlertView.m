//
//  YYAlertView.m
//  DDFood
//
//  Created by YZ Y on 16/7/11.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYAlertView.h"
#import "YYDealCancelView.h"
#import "YYCertifyAlertView.h"
#import "YYDamageDetailSuspendView.h"

@interface YYAlertView ()
@property (nonatomic, weak) YYDealCancelView *cancelView;
@property (nonatomic, weak) YYCertifyAlertView *certifyView;
@property (nonatomic, weak) YYDamageDetailSuspendView *damageDetailView;
@property (nonatomic, weak) UIView *functionView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UIButton *cancelButton;

@end

@implementation YYAlertView

{
    YYAlertViewType _type;
    YYCancelReasonType _cancelReasonType;
    NSString *_name;
    NSString *_code;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _contentView = view;
    }
    return _contentView;
}


- (YYDealCancelView *)cancelView {
    if (!_cancelView) {
        YYDealCancelView *view = [[YYDealCancelView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(700), RELATIVE_WIDTH(500))];
        [self.contentView addSubview:view];
        _cancelView = view;
    }
    return _cancelView;
}

- (YYCertifyAlertView *)certifyView {
    if (!_certifyView) {
        YYCertifyAlertView *view = [[YYCertifyAlertView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(500))];
        [self.contentView addSubview:view];
        _certifyView = view;
    }
    return _certifyView;
}

- (YYDamageDetailSuspendView *)damageDetailView {
    if (!_damageDetailView) {
        YYDamageDetailSuspendView *view = [[YYDamageDetailSuspendView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(570), RELATIVE_WIDTH(522))];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _damageDetailView = view;
    }
    return _damageDetailView;
}


- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.backgroundColor = [UIColor whiteColor];
        cancelButton.layer.borderColor = YYGrayTextColor.CGColor;
        cancelButton.layer.borderWidth = RELATIVE_WIDTH(2);
        cancelButton.layer.cornerRadius = CommonCornerRadius;
        cancelButton.layer.masksToBounds = YES;
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.functionView addSubview:cancelButton];
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.backgroundColor = YYDisableColor;
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        sureButton.layer.cornerRadius = CommonCornerRadius;
        sureButton.layer.masksToBounds = YES;
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        sureButton.enabled = NO;
        [self.functionView addSubview:sureButton];
        _sureButton = sureButton;
    }
    return _sureButton;
}

- (UIView *)functionView {
    if (!_functionView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _functionView = view;
    }
    return _functionView;
}


- (instancetype)initWithType:(YYAlertViewType)type
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT);
        self.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        [self contentView];
        [self functionView];
        _type = type;
        WS(ws);
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.functionView).offset(RELATIVE_WIDTH(90));
            make.centerY.equalTo(self.functionView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(60)));
        }];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.functionView).offset(-RELATIVE_WIDTH(90));
            make.centerY.equalTo(self.functionView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(60)));
        }];
        switch (_type) {
            case YYAlertViewTypeNormal:
            {
                break;
            }
            case YYAlertViewTypeCancelDeal:
            {
                self.cancelView.didSelectReasonBlock = ^(YYCancelReasonType reasonType) {
                    StrongSelf(strongSelf);
                    strongSelf = ws;
                    strongSelf.sureButton.enabled = reasonType != YYCancelReasonTypeNone;
                    strongSelf.sureButton.backgroundColor = self.sureButton.enabled ? YYGlobalColor : YYDisableColor;
                    if (reasonType != YYCancelReasonTypeNone) {
                        _cancelReasonType = reasonType;
                    }
                };
                
                [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(ws);
                    make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
                    make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
                    make.height.mas_equalTo(RELATIVE_WIDTH(700));
                }];
                
                [self.cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.equalTo(self.contentView);
                    make.height.mas_equalTo(RELATIVE_WIDTH(504));
                }];
                
                [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.cancelView.mas_bottom);
                    make.bottom.left.right.equalTo(self.contentView);
                }];
                
                break;
            }
            case YYAlertViewTypeCertify:
            {
                self.contentView.layer.cornerRadius = CommonCornerRadius;
                self.contentView.layer.masksToBounds = YES;
                self.certifyView.nameBlock = ^(NSString *name) {
                    _name = name;
                    StrongSelf(strongSelf);
                    strongSelf = ws;
                    strongSelf.sureButton.enabled = [_name isValid] && [_code isValid];
                    strongSelf.sureButton.backgroundColor = self.sureButton.enabled ? YYGlobalColor : YYDisableColor;
                };
                
                self.certifyView.codeBlock = ^(NSString *code) {
                    _code = code;
                    StrongSelf(strongSelf);
                    strongSelf = ws;
                    strongSelf.sureButton.enabled = [_name isValid] && [_code isValid];
                    strongSelf.sureButton.backgroundColor = self.sureButton.enabled ? YYGlobalColor : YYDisableColor;
                };
                
                [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(ws);
                    make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
                    make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
                    make.height.mas_equalTo(RELATIVE_WIDTH(700));
                }];
                
                [self.certifyView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.equalTo(self.contentView);
                    make.height.mas_equalTo(RELATIVE_WIDTH(504));
                }];
                
                [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.certifyView.mas_bottom);
                    make.bottom.left.right.equalTo(self.contentView);
                }];
                
                break;
            }
            case YYAlertViewTypeGoodsDamageImage:
            {
                self.cancelButton.hidden = YES;
                self.contentView.layer.cornerRadius = CommonCornerRadius;
                self.contentView.layer.masksToBounds = YES;
                [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(ws);
                    make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(570), RELATIVE_WIDTH(522)));
                }];
                
                [self.damageDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.right.equalTo(self.contentView);
                    make.height.mas_equalTo(RELATIVE_WIDTH(412));
                }];
                
                [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.left.right.equalTo(self.contentView);
                    make.height.mas_equalTo(RELATIVE_WIDTH(112));
                }];
                
                [self bringSubviewToFront:self.functionView];
                
                [self.sureButton setTitle:@"知道了" forState:UIControlStateNormal];
                self.sureButton.backgroundColor = YYGlobalColor;
                self.sureButton.enabled = YES;
                [self.sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self.functionView);
                    make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(150), RELATIVE_WIDTH(60)));
                }];
                break;
            }
        }
    }
    return self;
}

- (void)setGoodsDamageImageArray:(NSArray *)goodsDamageImageArray
{
    _goodsDamageImageArray = goodsDamageImageArray;
    self.damageDetailView.imageArray = goodsDamageImageArray;
}

- (void)hide
{
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)show
{
    [(mAppDelegate).window addSubview:self];
}

#pragma mark - function action
- (void)cancelAction
{
    [self hide];
}

- (void)sureAction
{
    if (_cancelBlock) {
        _cancelBlock(_cancelReasonType);
    }
    
    if (_certifyBlock) {
        _certifyBlock(_name, _code);
    }
    
    [self hide];
}

+ (void)alterViewWithCancelButton:(NSString *)cancelButton sureButton:(NSString *)sureButton target:(id)target cancelAction:(SEL)cancelAction sureAction:(SEL)surelAction
{
    
}


@end
