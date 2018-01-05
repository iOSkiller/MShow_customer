//
//  YYChangeReturnModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYChangeReturnModel : NSObject
@property (nonatomic, assign) YYChangeGoodsType changeType;
@property (nonatomic, copy) NSString *changeTypeContent;
@property (nonatomic, assign) YYReturnChangeReasonType reasonType;
@property (nonatomic, copy) NSString *reasonTypeContent;
+ (NSArray *)testTypeArray;
+ (NSArray *)testReasonArray;

@end
