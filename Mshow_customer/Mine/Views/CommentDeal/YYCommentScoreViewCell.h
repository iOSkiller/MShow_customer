//
//  YYCommentScoreViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCommentScoreViewCell : UITableViewCell
@property (nonatomic, assign) YYScoreType scoreType;
@property (nonatomic, copy) void (^didMarkBlock)(YYScoreType type, double score);

@end
