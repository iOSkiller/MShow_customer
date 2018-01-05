//
//  YYChargeSumModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYChargeSumModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *sum;

+ (NSArray *)testDataArray;

@end
