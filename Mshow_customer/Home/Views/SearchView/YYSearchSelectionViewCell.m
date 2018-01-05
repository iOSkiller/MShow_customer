//
//  YYSearchSelectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchSelectionViewCell.h"

@implementation YYSearchSelectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xf4f4f4);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.masksToBounds = YES;
        [self.contentView addSubview:label];
        _contentLabel = label;
        WS(ws);
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
    }
    return self;
}
@end
