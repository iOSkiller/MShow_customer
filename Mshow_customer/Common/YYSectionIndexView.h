//
//  YYSectionIndexView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYSectionIndexView;

@protocol YYSectionIndexViewDelegate <NSObject>

@optional
- (void)sectionIndexView:(YYSectionIndexView *)sectionIndexView didSelectedIndex:(NSInteger)index;

@end

@interface YYSectionIndexView : UIView
- (instancetype)initWithFrame:(CGRect)frame sectionArray:(NSArray *)sectionArray;
- (void)scrolltoIndex:(NSInteger)index;

@property (nonatomic, weak) id <YYSectionIndexViewDelegate> delegate;

@end
