//
//  YYPopView.h
//  DDFood
//
//  Created by YZ Y on 16/10/21.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYArrowView.h"

@protocol YYPopViewDelegate <NSObject>

- (void)clickItemInPopView:(NSInteger)index;

@end

@interface YYPopView : YYArrowView
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, weak) id <YYPopViewDelegate> delegate;
- (void)setTitleArray:(NSArray *)titleArray images:(NSArray *)imageArray;

@end
