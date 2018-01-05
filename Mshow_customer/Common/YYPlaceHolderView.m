//
//  YYPlaceHolderView.m
//  DDFood
//
//  Created by YZ Y on 16/7/2.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYPlaceHolderView.h"
#import "YYProgressView.h"

@interface YYPlaceHolderView ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIImageView *gifView;
@property (nonatomic, weak) YYProgressView *progressView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *shoppingButton;
@property (nonatomic, weak) UIButton *promotionButton;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation YYPlaceHolderView

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startReload)];
    }
    return _tap;
}

- (YYProgressView *)progressView {
    if (!_progressView) {
        YYProgressView *view = [[YYProgressView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(80), RELATIVE_WIDTH(80))];
        //设置轨道颜色
        view.trackTintColor = mRGBToColor(0xf6f3f3);
        //设置进度条颜色
        view.progressTintColor = YYGlobalColor;
        //设置轨道宽度
        view.lineWidth = 2.0;
//        //设置进度
        view.progressValue = 0.3;
        [self addSubview:view];
        _progressView = view;
    }
    return _progressView;
}


- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.textColor = YYDiscriptionColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (UIButton *)shoppingButton {
    if (!_shoppingButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"去逛逛" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [button addTarget:self action:@selector(clickShoppingButton) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.backgroundColor = YYGlobalColor;
        [self addSubview:button];
        _shoppingButton = button;
    }
    return _shoppingButton;
}

- (UIButton *)promotionButton {
    if (!_promotionButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"去优惠" forState:UIControlStateNormal];
        [button setTitleColor:YYGlobalColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [button addTarget:self action:@selector(clickPromotionButton) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.borderColor = YYGlobalColor.CGColor;
        button.layer.borderWidth = RELATIVE_WIDTH(1);
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];
        _promotionButton = button;
    }
    return _promotionButton;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [UIImageView new];
        [self addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}

- (UIImageView *)gifView {
    if (!_gifView) {
        UIImageView *imgView = [UIImageView new];
        [self addSubview:imgView];
        
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [images addObject:image];
        }
        
        imgView.animationRepeatCount = MAXFLOAT;
        imgView.animationImages = images;
        imgView.animationDuration = 1;
        _gifView = imgView;
    }
    return _gifView;
}



- (instancetype)init
{
    if (self = [super init]) {
        self.hidden = YES;
        self.backgroundColor = mRGBToColor(0xf6f3f3);
        self.label.hidden = YES;
        self.gifView.hidden = YES;
        self.imgView.hidden = YES;
        self.progressView.hidden = YES;
        self.shoppingButton.hidden = YES;
        self.promotionButton.hidden = YES;
        
    }
    return self;
}


- (void)setImage:(NSString *)image type:(YYPlaceHolderViewType)type
{
    self.hidden = NO;
    CGSize imgSize = CGSizeZero;
    [self removeGestureRecognizer:self.tap];
    WS(ws)
    switch (type) {
        case YYPlaceHolderViewTypeLoading:
        {
            self.progressView.hidden = NO;
            self.imgView.hidden = NO;
            self.imgView.image = [UIImage imageNamed:@"icon_placeholder"];
            self.backgroundColor = [UIColor whiteColor];
            /**subview在superview中的层次*/
            [self insertSubview:self.progressView aboveSubview:self.imgView];
            imgSize = CGSizeMake(RELATIVE_WIDTH(220), RELATIVE_WIDTH(220));
            [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imgSize);
                make.centerX.equalTo(ws);
                make.top.equalTo(ws.mas_centerY).offset(-RELATIVE_WIDTH(220));
            }];
            
            [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(60), RELATIVE_WIDTH(60)));
                make.bottom.equalTo(self.imgView.mas_top).offset(RELATIVE_WIDTH(76));
                make.centerX.equalTo(ws);
            }];
            
            [self.progressView startAnimation];
            
        }
            
            break;
        case YYPlaceHolderViewTypeGif:
        {
            self.progressView.hidden = YES;
            self.imgView.hidden = YES;
            self.gifView.hidden = NO;
            imgSize = CGSizeMake(RELATIVE_WIDTH(160), RELATIVE_WIDTH(160));
            [self.gifView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(ws);
                make.size.mas_equalTo(imgSize);
            }];
            [self.gifView startAnimating];
            break;
        }
            
        case YYPlaceHolderViewTypeShoppingCart:
        {
            self.progressView.hidden = YES;
            self.imgView.hidden = NO;
            self.shoppingButton.hidden = NO;
            self.promotionButton.hidden = NO;
            imgSize = CGSizeMake(RELATIVE_WIDTH(152), RELATIVE_WIDTH(152));
            CGSize buttonSize = CGSizeMake(RELATIVE_WIDTH(168), RELATIVE_WIDTH(64));
            self.imgView.image = [UIImage imageNamed:@"shopping_none"];
            self.label.text = @"您的购物车中没有商品";
            
            [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(ws.mas_centerX);
                make.top.equalTo(ws.mas_top).offset(RELATIVE_WIDTH(100));
                make.size.mas_equalTo(imgSize);
            }];
            
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(26));
                make.left.equalTo(ws.mas_left).offset(RELATIVE_WIDTH(20));
                make.right.equalTo(ws.mas_right).offset(-RELATIVE_WIDTH(20));
                make.height.mas_equalTo(RELATIVE_WIDTH(30));
            }];
            
            [self.shoppingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.label.mas_bottom).offset(RELATIVE_WIDTH(22));
                make.centerX.equalTo(ws.mas_centerX);
                make.size.mas_equalTo(buttonSize);
            }];
            
            [self.promotionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.shoppingButton.mas_bottom).offset(RELATIVE_WIDTH(22));
                make.centerX.equalTo(ws.mas_centerX);
                make.size.mas_equalTo(buttonSize);
            }];
            break;
        }
            
        case YYPlaceHolderViewTypeFailed:
        {
            self.backgroundColor = [UIColor whiteColor];
            self.progressView.hidden = YES;
            self.shoppingButton.hidden = YES;
            self.promotionButton.hidden = YES;
            self.imgView.hidden = NO;
            self.imgView.image = [UIImage imageNamed:@"icon_placeholder"];
            self.label.hidden = NO;
            self.label.text = @"点击屏幕重新加载";
            self.label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
            self.label.textColor = mRGBToColor(0xebebeb);
            /**subview在superview中的层次*/
            [self insertSubview:self.label aboveSubview:self.imgView];
            imgSize = CGSizeMake(RELATIVE_WIDTH(220), RELATIVE_WIDTH(220));
            [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imgSize);
                make.centerX.equalTo(ws);
                make.centerY.equalTo(ws.mas_centerY).mas_offset(-RELATIVE_WIDTH(110));
            }];
            
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(RELATIVE_WIDTH(50));
                make.left.right.equalTo(ws);
                make.top.equalTo(self.imgView.mas_bottom).offset(-RELATIVE_WIDTH(80));
            }];
            [self addGestureRecognizer:self.tap];
            break;
        }
            
            
        case YYPlaceHolderViewTypeNoneDeal:
        {
            self.progressView.hidden = YES;
            self.imgView.hidden = NO;
            self.label.hidden = NO;
            self.label.textColor = YYDiscriptionColor;
            self.label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
            self.imgView.image = [UIImage imageNamed:image];
            self.label.text = @"暂无记录";
            /**subview在superview中的层次*/
            [self insertSubview:self.label aboveSubview:self.imgView];
            imgSize = CGSizeMake(RELATIVE_WIDTH(152), RELATIVE_WIDTH(152));
            [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(ws.mas_centerX);
                make.top.equalTo(ws.mas_top).offset(RELATIVE_WIDTH(100));
                make.size.mas_equalTo(imgSize);
            }];
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(26));
                make.left.equalTo(ws.mas_left).offset(RELATIVE_WIDTH(20));
                make.right.equalTo(ws.mas_right).offset(-RELATIVE_WIDTH(20));
                make.height.mas_equalTo(RELATIVE_WIDTH(30));
            }];
            break;
        }
           
    }
    
}

#pragma mark - buttonAction
- (void)clickShoppingButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(backHome)]) {
        [_delegate backHome];
    }
}

- (void)clickPromotionButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(gotoPromotion)]) {
        [_delegate gotoPromotion];
    }
}

- (void)startReload
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapToReload)]) {
        [_delegate tapToReload];
    }
}

- (void)show
{
    self.hidden = NO;
}

- (void)dismiss
{
    self.hidden = YES;
//    [self removeFromSuperview];
}

@end
