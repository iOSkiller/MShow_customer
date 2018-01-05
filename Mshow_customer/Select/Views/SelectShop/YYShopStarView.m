//
//  YYShopStarView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopStarView.h"

@implementation YYShopStarView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createStars
{
    for (int i = 0; i < self.starsCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.starImage == nil ? [UIImage imageNamed:@"img_star"] : self.starImage];
        [self addSubview:imageView];
        if (self.mj_h > RELATIVE_WIDTH(44)) {
            imageView.frame = CGRectMake(i * (RELATIVE_WIDTH(4) + RELATIVE_WIDTH(40)), RELATIVE_WIDTH(4), RELATIVE_WIDTH(40), RELATIVE_WIDTH(40));
        } else {
            imageView.frame = CGRectMake(i * (0 + self.mj_h), 0, self.mj_h, self.mj_h);
        }
        
    }
}

- (void)setStarsCount:(NSInteger)starsCount starImage:(UIImage *)starImage
{
    _starsCount = starsCount;
    _starImage = starImage;
    [self createStars];
}

- (void)setStarImage:(UIImage *)starImage
{
    _starImage = starImage;
    [self createStars];
}

- (void)setStarsCount:(NSInteger)starsCount
{
    _starsCount = starsCount;
    [self createStars];
}

@end
