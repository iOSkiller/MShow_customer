//
//  YYCancelReasonModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCancelReasonModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) YYCancelReasonType type;
+ (NSArray *)dataArray;

@end
