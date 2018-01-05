//
//  YYMineFunctionViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMineFunctionViewCell : UICollectionViewCell
@property (nonatomic, weak) UILabel *titleLabel;
- (void)setImage:(UIImage *)image title:(NSString *)title;
- (void)setTitle:(NSString *)title countInfo:(NSString *)countInfo;

@end
