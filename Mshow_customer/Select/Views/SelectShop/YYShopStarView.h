//
//  YYShopStarView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYShopStarView : UIView
@property (nonatomic, assign) NSInteger starsCount;
@property (nonatomic, strong) UIImage *starImage;
- (void)setStarsCount:(NSInteger)starsCount starImage:(UIImage *)starImage;

@end
