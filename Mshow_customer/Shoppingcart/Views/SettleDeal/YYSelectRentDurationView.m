//
//  YYSelectRentDurationView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectRentDurationView.h"
#import "YYSelectDateView.h"
#import "YYSelectDurationView.h"

@interface YYSelectRentDurationView ()
@property (nonatomic, weak) YYSelectDateView *selectDateView;
@property (nonatomic, weak) YYSelectDurationView *selectDurationView;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIImageView *arrowView;
@property (nonatomic, weak) UILabel *dayLabel;
@property (nonatomic, weak) UILabel *selectDaysLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UIButton *sureButton;

@end

@implementation YYSelectRentDurationView

{
    NSUInteger  _duration;
    NSString *_dateForRecieve;
}

- (YYSelectDateView *)selectDateView {
    if (!_selectDateView) {
        YYSelectDateView *view = [[YYSelectDateView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(86) * 8 + RELATIVE_WIDTH(20))];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _selectDateView = view;
    }
    return _selectDateView;
}

- (YYSelectDurationView *)selectDurationView {
    if (!_selectDurationView) {
        YYSelectDurationView *view = [[YYSelectDurationView alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(116), RELATIVE_WIDTH(96), RELATIVE_WIDTH(300), RELATIVE_WIDTH(44) * 5)];
        [self addSubview:view];
        _selectDurationView = view;
    }
    return _selectDurationView;
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

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"   天数";
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self addSubview:label];
        _dayLabel = label;
    }
    return _dayLabel;
}

- (UILabel *)selectDaysLabel {
    if (!_selectDateView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(300), RELATIVE_WIDTH(60))];
        label.backgroundColor = YYSeparatorColor;
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.text = @"   请选择试穿天数";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDaysAction)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        
        _selectDaysLabel = label;
    }
    return _selectDaysLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYSeparatorColor;
        [self addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = YYDisableColor;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.enabled = NO;
        [self addSubview:button];
        _sureButton = button;
    }
    return _sureButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self dayLabel];
        [self selectDaysLabel];
        [self line];
        [self selectDateView];
        [self priceLabel];
        [self sureButton];
        [self selectDurationView];
        
        WS(weakSelf);
        NSArray *durationArray = @[@"3", @"5", @"7", @"10", @"15"];
        self.selectDurationView.selectionArray = durationArray;
        self.selectDurationView.didSelectDurationBlock = ^(NSUInteger days) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            strongSelf.selectDaysLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
            strongSelf.selectDaysLabel.text = [NSString stringWithFormat:@"   %@天", @(days)];
            strongSelf.priceLabel.attributedText = [NSString str1:@"   体验费" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:[NSString stringWithFormat:@"￥%.2f", days * 3.00] font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
            _duration = days;
            strongSelf.selectDateView.duration = days;
//            self.sureButton.enabled = [_dateForRecieve isValid];
            strongSelf.sureButton.enabled = YES;
            strongSelf.sureButton.backgroundColor = strongSelf.sureButton.enabled ? YYGlobalColor : YYDisableColor;
        };
        [self bringSubviewToFront:self.selectDurationView];
        
        self.selectDateView.selectDateBlock = ^(NSInteger day, NSInteger month, NSInteger year) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            _dateForRecieve = [NSString stringWithFormat:@"%@-%02ld-%02ld", @(year), (long)month, (long)day];
//            self.sureButton.enabled = _duration > 0;
            strongSelf.sureButton.enabled = YES;
            strongSelf.sureButton.backgroundColor = strongSelf.sureButton.enabled > 0 ? YYGlobalColor : YYDisableColor;
        };
        
        self.priceLabel.attributedText = [NSString str1:@"   体验费" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:@"￥0.0" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
        WS(ws);
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.mas_equalTo(RELATIVE_WIDTH(90));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(36));
        }];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_down"]];
        imageView.backgroundColor = YYSeparatorColor;
        [self addSubview:imageView];
        [self bringSubviewToFront:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selectDaysLabel);
            make.right.equalTo(self.selectDaysLabel).offset(-RELATIVE_WIDTH(30));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(36));
        }];
        _arrowView = imageView;
        [self.selectDaysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dayLabel.mas_right).offset(RELATIVE_WIDTH(26));
            make.centerY.equalTo(self.dayLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(60)));
        }];
        
        
        [self.selectDurationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectDaysLabel.mas_bottom);
            make.left.right.equalTo(self.selectDaysLabel);
            make.height.mas_equalTo(RELATIVE_WIDTH(44) * durationArray.count);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(99));
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.selectDateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_bottom);
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(86) * 8 + RELATIVE_WIDTH(20));
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectDateView.mas_bottom);
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom).offset(RELATIVE_WIDTH(60));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(30));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(30));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
    }
    return self;
}

- (void)setType:(YYSelectRentDurationViewType)type
{
    _type = type;
    if (type == YYSelectRentDurationViewTypeDate) {
        self.dayLabel.hidden = YES;
        self.selectDaysLabel.hidden = YES;
        self.line.hidden = YES;
        self.priceLabel.hidden = YES;
        self.selectDateView.hideInfoLabel = YES;
        self.arrowView.hidden = YES;
    }
}

- (void)setDate:(NSDate *)date
{
    [self.selectDateView setDateForRecieve:date];
}

- (void)selectDaysAction
{
    self.selectDurationView.hidden = !self.selectDurationView.hidden;
}

- (void)sureAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeSureAction:dateForRecieve:)]) {
        [_delegate executeSureAction:_duration dateForRecieve:_dateForRecieve];
    }
}

@end
