//
//  YYDefectModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDefectModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *defectID;
+ (NSArray *)testDataAarray;

@end
