//
//  YYCommentModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYGoodsModel;

typedef NS_ENUM(NSInteger, YYCommentType) {
    YYCommentTypeNormal,
    YYCommentTypeShow,
};

@interface YYCommentModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *commentID;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *upvoteCount;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) YYCommentType type;
@property (nonatomic, strong) YYGoodsModel *goodsModel;

+ (NSArray *)testShowDataArray;
+ (NSArray *)testNormalDataArray;

@end
