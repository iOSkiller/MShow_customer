//
//  YYDotLineView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDotLineView.h"

@implementation YYDotLineView

- (instancetype)initWithFrame:(CGRect)frame dotCount:(NSUInteger)dotCount
{
    if (self = [super initWithFrame:frame]) {
        UIView *lastView = nil;
        for (int i = 0; i < dotCount; i ++) {
            WS(ws);
            if (i == dotCount - 1) {
                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_xuanzhongactived"]];
                imgView.backgroundColor = YYGlobalColor;
                imgView.layer.cornerRadius = RELATIVE_WIDTH(18);
                imgView.layer.masksToBounds = YES;
                [self addSubview:imgView];
                [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(ws);
                    make.centerY.equalTo(ws);
                    make.width.height.mas_equalTo(RELATIVE_WIDTH(36));
                }];
            }
            
            if (i < dotCount - 1) {
                UIView *dotView = [UIView new];
                dotView.layer.cornerRadius = RELATIVE_WIDTH(8);
                dotView.layer.masksToBounds = YES;
                dotView.backgroundColor = YYGlobalColor;
                [self addSubview:dotView];
                
                CGFloat width = (frame.size.width - RELATIVE_WIDTH(16) * (dotCount - 1) - RELATIVE_WIDTH(36)) / (dotCount - 1);
                
                [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
                    lastView ? make.left.equalTo(lastView.mas_right).offset(width) : make.left.equalTo(ws);
                    make.centerY.equalTo(ws);
                    make.width.height.mas_equalTo(RELATIVE_WIDTH(16));
                }];
                
                lastView = dotView;
                
                if (lastView) {
                    UIView *line = [UIView new];
                    line.backgroundColor = YYGlobalColor;
                    [self addSubview:line];
                    
                    [line mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(ws);
                        make.centerY.equalTo(lastView);
                        make.height.mas_equalTo(RELATIVE_WIDTH(6));
                        
                    }];
                }
            }
        }
    }
    return self;
}

@end
