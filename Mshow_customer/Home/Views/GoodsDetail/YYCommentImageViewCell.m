//
//  YYCommentImageViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentImageViewCell.h"

@interface YYCommentImageViewCell ()
@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation YYCommentImageViewCell

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setImage:(NSString *)image
{
    _image = image;
    self.imgView.image = [UIImage clipImage:[UIImage imageNamed:image] toRect:self.contentView.bounds.size];
}

@end
