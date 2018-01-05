//
//  YYCommentDefectSeletionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYDefectModel;

@interface YYCommentDefectSeletionView : UIView
@property (nonatomic, copy) void (^didSelectBlock)(NSArray *defectArray);
@property (nonatomic, copy) NSArray *selectionArray;

@end
