//
//  YYShopGoodsDisplayViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopGoodsDisplayViewCell.h"

@interface YYShopGoodsDisplayViewCell ()
@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation YYShopGoodsDisplayViewCell

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        _imgView = view;
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

- (void)setImgURL:(NSString *)imgURL
{
    _imgURL = imgURL;
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@""]];
    self.imgView.image = [UIImage clipImage:[UIImage imageNamed:imgURL] toRect:self.bounds.size];
}

@end
