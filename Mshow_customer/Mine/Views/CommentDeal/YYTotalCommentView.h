//
//  YYTotalCommentView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYCommentModel;

@interface YYTotalCommentView : UIView
@property (nonatomic, copy) void (^changeMarkBlock)(double score);
@property (nonatomic, strong) YYCommentModel *commentModel;

@end
