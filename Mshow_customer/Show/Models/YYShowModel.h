//
//  YYShowModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/31.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYShowModel : NSObject
@property (nonatomic, assign) BOOL isFollow;
@property (nonatomic, assign) BOOL isUpvoted;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray *imageURLs;
@property (nonatomic, copy) NSArray *images;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat imageContainerHeight;
@property (nonatomic, assign) CGSize itemSize;

+ (NSArray *)testArray;

@end
