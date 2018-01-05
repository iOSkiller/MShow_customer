//
//  YYShowViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/31.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYShowModel;

@interface YYShowViewCell : UITableViewCell
@property (nonatomic, copy) void (^reportBlock)(YYShowModel *showModel);
@property (nonatomic, copy) void (^followBlock)(YYShowModel *showModel);
@property (nonatomic, copy) void (^commentBlock)(YYShowModel *showModel);
@property (nonatomic, copy) void (^upvoteBlock)(YYShowModel *showModel);
@property (nonatomic, copy) void (^shareBlock)(YYShowModel *showModel);
@property (nonatomic, copy) void (^showImageBlock)(NSArray *urlArray, NSInteger index);
@property (nonatomic, strong) YYShowModel *showModel;
- (void)setItemSize:(CGSize)itemSize contentHeight:(CGFloat)contentHeight imageContainerHeight:(CGFloat)imageContainerHeight;

@end
