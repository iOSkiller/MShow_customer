//
//  YYReturnGoodsFunctionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYReturnGoodsFunctionView.h"
#import "YYButton.h"

@interface YYReturnGoodsFunctionView ()
@property (nonatomic, weak) YYButton *selectButton;
@property (nonatomic, weak) UIButton *sureButton;

@end

@implementation YYReturnGoodsFunctionView

- (YYButton *)selectButton {
    if (!_selectButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"全选" selectedRightTitle:nil];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.normalColor = YYTextColor;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.enabled = NO;
        button.backgroundColor = YYDisableColor;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _sureButton = button;
    }
    return _sureButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(1))];
        line.backgroundColor = YYSeparatorColor;
        [self addSubview:line];
        
        WS(ws);
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.width.mas_equalTo(RELATIVE_WIDTH(110));
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.centerY.equalTo(ws);
        }];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(60));
            make.centerY.equalTo(ws);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(160), RELATIVE_WIDTH(60)));
        }];
    }
    return self;
}

- (void)selectButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.sureButton.enabled = sender.isSelected;
    self.sureButton.backgroundColor = sender.isSelected ? YYGlobalColor : YYDisableColor;
    if (_selectAllBlock) {
        _selectAllBlock(sender.isSelected);
    }
}

- (void)setHaveSelectdGoods:(BOOL)haveSelectdGoods
{
    _haveSelectdGoods = haveSelectdGoods;
    self.sureButton.enabled = haveSelectdGoods;
    self.sureButton.backgroundColor = haveSelectdGoods ? YYGlobalColor : YYDisableColor;
    
}

- (void)setIsAllSelected:(BOOL)isAllSelected
{
    _isAllSelected = isAllSelected;
    self.selectButton.selected = isAllSelected;
}

- (void)sureAction
{
    if (_sureActionBlock) {
        _sureActionBlock();
    }
}

@end
