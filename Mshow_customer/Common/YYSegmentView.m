//
//  YYSegmentView.m
//  DDFood
//
//  Created by YZ Y on 16/6/22.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYSegmentView.h"

@interface YYSegmentView ()
@property (nonatomic, strong) NSArray *itemArr;

@end

@implementation YYSegmentView

{
    NSInteger index;
    BOOL      priceUP;
}


- (instancetype)initWithFrame:(CGRect)frame selections:(NSArray *)selectionsArr {
    if (self = [super initWithFrame:frame]) {
        _itemArr = selectionsArr;
        index = 0;
        WS(ws);
        UIView *lastView = nil;
        CGFloat width = self.mj_w / _itemArr.count;
        for (int i = 0; i < _itemArr.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:_itemArr[i] forState:UIControlStateNormal];
            [button setTitleColor:YYDiscriptionColor forState:UIControlStateNormal];
            [button setTitleColor:YYGlobalColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(clickSelecton:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
            button.tag = 400 + i;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
                make.top.bottom.equalTo(ws);
                lastView ? make.left.equalTo(lastView.mas_right) : make.left.equalTo(ws.mas_left);
            }];
            lastView = button;
            if (i == 0) {
                button.selected = YES;
                index = button.tag;
            }
            if (i == 2) {
                [button setImage:[UIImage imageNamed:@"price_normal"] forState:UIControlStateNormal];
                CGFloat titleWidth = [button.currentTitle getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(30))].size.width;
                CGFloat imgWith = button.currentImage.size.width;
                button.titleEdgeInsets = UIEdgeInsetsMake(0, -imgWith, 0, imgWith);
                button.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth, 0, -titleWidth);
            }
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame leftMargin:(CGFloat)leftMargin magrin:(CGFloat)margin selections:(NSArray *)selectionsArr
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        index = 0;
        WS(ws);
        
        for (int i = 0; i < selectionsArr.count; i ++) {
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
            label.textColor = YYGrayTextColor;
            label.backgroundColor = [UIColor whiteColor];
            label.text = selectionsArr[i];
            label.tag = 600 + i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
            [label addGestureRecognizer:tap];
            label.userInteractionEnabled = YES;
            [self addSubview:label];
            
            if (selectionsArr.count == 3) {
                switch (i) {
                    case 0:
                    {
                        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(ws).offset(leftMargin);
                            make.width.greaterThanOrEqualTo(@0);
                            make.bottom.top.equalTo(ws);
                        }];
                    }
                        break;
                    case 1:
                    {
                        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(ws);
                            make.width.greaterThanOrEqualTo(@0);
                            make.bottom.top.equalTo(ws);
                        }];
                    }
                        break;
                    case 2:
                    {
                        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(ws).offset(-leftMargin);
                            make.width.greaterThanOrEqualTo(@0);
                            make.bottom.top.equalTo(ws);
                        }];
                    }
                        break;
                    default:
                        break;
                }
            } else {
                UIView *lastView = nil;
                CGFloat width = (self.mj_w - margin * (selectionsArr.count - 1) - leftMargin * 2) / selectionsArr.count;
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(width);
                    make.top.bottom.equalTo(ws);
                    lastView ? make.left.equalTo(lastView.mas_right).offset(margin) : make.left.equalTo(ws.mas_left).offset(leftMargin);
                }];
                lastView = label;
            }
            
            if (i == 0) {
                label.textColor = YYGlobalColor;
            }
            
        }
        
        
    }
    return self;
}

- (void)titleClick:(UITapGestureRecognizer *)tap
{
    // 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    
    // 获取当前角标
    NSInteger i = label.tag;
    label.textColor = YYGlobalColor;
    
    UILabel *lastLabel = (UILabel *)[self viewWithTag:index + 600];
    lastLabel.textColor = YYGrayTextColor;
    
    index = i - 600;
    if (_delegate && [_delegate respondsToSelector:@selector(clickSelectionID:ascending:)]) {
        [_delegate clickSelectionID:[NSString stringWithFormat:@"%ld", (long)(index)] ascending:NO];
    }
}

- (void)setSeparator:(UIColor *)separatorColor height:(CGFloat)height
{
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, height)];
    line1.backgroundColor = separatorColor;
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.mj_h - height, self.mj_w, height)];
    line2.backgroundColor = separatorColor;
    [self addSubview:line2];
}

- (void)refresh
{
    for (UIButton *button in self.subviews) {
        if ((button.tag - 400) == 0) {
            button.selected = YES;
            index = button.tag;
        } else {
            button.selected = NO;
        }
        
    }
}

- (void)clickSelecton:(UIButton *)sender
{
    [GCDThrottle throttle:0.3 block:^{
        
    }];
    
    if (sender.tag == 402) {
        if (index && index != 402) {
            UIButton *button = (UIButton *)[self viewWithTag:index];
            button.selected = NO;
            sender.selected = YES;
            priceUP = NO;
            index = sender.tag;
        }
        
        priceUP = !priceUP;
        priceUP ? [sender setImage:[UIImage imageNamed:@"price_up"] forState:UIControlStateSelected] : [sender setImage:[UIImage imageNamed:@"price_down"] forState:UIControlStateSelected];
        sender.selected = YES;
        
        index = sender.tag;
        [_delegate clickSelectionID:[NSString stringWithFormat:@"%ld", (long)(sender.tag - 400)] ascending:priceUP];
        return;
    }
    
    if (index) {
        UIButton *button = (UIButton *)[self viewWithTag:index];
        button.selected = NO;
        sender.selected = YES;
        index = sender.tag;
    } else {
        index = sender.tag;
        sender.selected = YES;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickSelectionID:ascending:)]) {
        [_delegate clickSelectionID:[NSString stringWithFormat:@"%ld", (long)(sender.tag - 400)] ascending:NO];
    }
    
}

@end
