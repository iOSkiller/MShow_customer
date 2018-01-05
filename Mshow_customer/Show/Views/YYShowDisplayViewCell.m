//
//  YYShowDisplayViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/31.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShowDisplayViewCell.h"

@interface YYShowDisplayViewCell ()
@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation YYShowDisplayViewCell

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
    }
    return self;
}

- (void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
    self.imgView.image = [UIImage clipImage:[UIImage imageNamed:imageURL] toRect:self.mj_size];
}


@end
