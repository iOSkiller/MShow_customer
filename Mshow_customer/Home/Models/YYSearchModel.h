//
//  YYSearchModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSearchModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) CGFloat content_width;
@property (nonatomic, assign) CGFloat content_height;
+ (NSArray *)testHistoryArray;
+ (NSArray *)testHotArray;

@end
