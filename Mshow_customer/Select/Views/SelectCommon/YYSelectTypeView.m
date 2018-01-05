//
//  YYSelectTypeView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectTypeView.h"

@interface YYSelectTypeView ()
@property (nonatomic, copy) NSArray *itemArr;

@end

@implementation YYSelectTypeView

{
    NSInteger _index;
}


- (instancetype)initWithFrame:(CGRect)frame selections:(NSArray *)selectionsArr {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _itemArr = selectionsArr;
        _index = 0;
        WS(ws);
        UIView *lastView = nil;
        CGFloat width = (self.mj_w - RELATIVE_WIDTH(24) * 2 - RELATIVE_WIDTH(46) * 3) / _itemArr.count;
        for (int i = 0; i < _itemArr.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:_itemArr[i] forState:UIControlStateNormal];
            [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:@"img_arrow_down"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"img_arrow_up_white"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(clickSelecton:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
            
            CGFloat titleWidth = [button.currentTitle getStringRect:button.titleLabel.font size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(30))].size.width;
            CGFloat imgWidth = button.currentImage.size.width;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -imgWidth + RELATIVE_WIDTH(18), 0, imgWidth);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + RELATIVE_WIDTH(18), 0, -titleWidth);
            
            button.tag = 400 + i;
            button.layer.cornerRadius = CommonCornerRadius;
            button.layer.masksToBounds = YES;
            button.backgroundColor = mRGBToColor(0xcccccc);
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
                make.top.equalTo(ws).offset(RELATIVE_WIDTH(16));
                make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(16));
                lastView ? make.left.equalTo(lastView.mas_right).offset(RELATIVE_WIDTH(46)) : make.left.equalTo(ws.mas_left).offset(RELATIVE_WIDTH(24));
            }];
            lastView = button;
            
            UIView *line1 = [UIView new];
            line1.backgroundColor = YYSeparatorColor;
            [self addSubview:line1];
            
            [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(ws);
                make.height.mas_equalTo(RELATIVE_WIDTH(1));
            }];
            
            UIView *line2 = [UIView new];
            line2.backgroundColor = YYSeparatorColor;
            [self addSubview:line2];
            
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.left.right.equalTo(ws);
                make.height.mas_equalTo(RELATIVE_WIDTH(1));
            }];
            
        }
    }
    return self;
}

- (void)refresh
{
    UIButton *button = (UIButton *)[self viewWithTag:_index];
    button.selected = NO;
    button.backgroundColor = mRGBToColor(0xcccccc);
}

- (void)clickSelecton:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    sender.backgroundColor = sender.selected ? YYGlobalColor : mRGBToColor(0xcccccc);
    [GCDThrottle throttle:0.3 block:^{
        
    }];
    
    if (_index && _index != sender.tag) {
        UIButton *button = (UIButton *)[self viewWithTag:_index];
        button.selected = NO;
        button.backgroundColor = mRGBToColor(0xcccccc);
//        sender.selected = YES;
        _index = sender.tag;
    } else {
        _index = sender.tag;
//        sender.selected = YES;
    }
    _index = sender.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(shouldShowSelectionView:index:)]) {
        [_delegate shouldShowSelectionView:sender.isSelected index:sender.tag];
    }
}

@end
