//
//  YYShowView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/31.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYShowModel;

@protocol YYShowViewDelegate <NSObject>
- (void)executeFunction:(YYShowViewFunctionType)type showModel:(YYShowModel *)showModel;
- (void)executeShowDetailImage:(NSArray *)imageURLS index:(NSInteger)index;

@end

@interface YYShowView : UIView
@property (nonatomic, weak) id <YYShowViewDelegate> delegate;
@property (nonatomic, copy) NSArray *dataArray;

@end
