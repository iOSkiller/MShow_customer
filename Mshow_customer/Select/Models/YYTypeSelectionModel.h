//
//  YYTypeSelectionModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYTypeSelectionModel : NSObject
@property (nonatomic, copy) NSString *selectionID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) CGFloat content_width;
@property (nonatomic, assign) BOOL isSelected;
+ (NSArray *)testCategoryDataArray;
+ (NSArray *)testTypeDataArray;
+ (NSArray *)testSizeDataArray;
+ (NSArray *)testMoreDataArray;

@end
