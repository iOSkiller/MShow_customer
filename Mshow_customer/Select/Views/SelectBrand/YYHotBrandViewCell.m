//
//  YYHotBrandViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHotBrandViewCell.h"
#import "YYImageTextView.h"
#import "YYBrandModel.h"

@interface YYHotBrandViewCell ()
@property (nonatomic, weak) YYImageTextView *imageTextView;

@end

@implementation YYHotBrandViewCell

- (YYImageTextView *)imageTextView {
    if (!_imageTextView) {
        YYImageTextView *view = [[YYImageTextView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        _imageTextView = view;
    }
    return _imageTextView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imageTextView];
    }
    return self;
}

- (void)setModel:(YYBrandModel *)model
{
    _model = model;
    self.imageTextView.label.text = @"NHUC";
}


@end
