//
//  YYGoodsSpecificationCell.m
//  DDFood
//
//  Created by YZ Y on 16/11/28.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYGoodsSpecificationCell.h"
#import "YYGoodsSpecificationModel.h"

#define nborderColor mRGBToColor(0xcacaca)

@interface YYGoodsSpecificationCell ()
@property (nonatomic, weak) UILabel *label;

@end

@implementation YYGoodsSpecificationCell

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.borderWidth = RELATIVE_WIDTH(1);
        label.layer.borderColor = nborderColor.CGColor;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:label];
        _label = label;
    }
    return _label;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self label];
    
    }
    return self;
}

- (void)setModel:(YYGoodsSpecificationModel *)model
{
//    _label.text = [NSString stringWithFormat:@"%@ %@kg/%@ %@", model.name, model.weight, model.unit, model.notes];
    _label.text = model.name;
    if (!model.enable) {
        _label.textColor = YYDisableColor;
        self.label.layer.borderColor = nborderColor.CGColor;
    } else {
        if (model.isSelected) {
            self.label.layer.borderColor = YYGlobalColor.CGColor;
            self.label.textColor = YYGlobalColor;
        } else {
            self.label.layer.borderColor = nborderColor.CGColor;
            self.label.textColor = YYTextColor;
        }
    }
    
    [self.label layoutIfNeeded];
    
    WS(ws);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
    }];
    
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    

}


@end
