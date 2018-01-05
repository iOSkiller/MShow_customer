//
//  YYImageTextView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYImageTextView.h"

@interface YYImageTextView ()

@end

@implementation YYImageTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self addSubview:label];
        _label = label;
        
        WS(ws);
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    return self;
}



@end
