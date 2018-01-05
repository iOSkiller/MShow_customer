//
//  YYMineViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMineViewCell : UITableViewCell
@property (nonatomic, assign) BOOL isFunction;
- (void)setImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray;
@property (nonatomic, copy) void (^fuctionBlock)(NSUInteger index);

@end
