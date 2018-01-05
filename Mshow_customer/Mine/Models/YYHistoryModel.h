//
//  YYHistoryModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHistoryModel : NSObject
@property (nonatomic, copy) NSArray *goodsArray;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *historyID;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSMutableArray *selectArray;

+ (NSArray *)testDataArray;

@end
