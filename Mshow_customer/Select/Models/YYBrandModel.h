//
//  YYBrandModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYBrandModel : NSObject
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *icon;
+ (NSArray *)testDataArray;

@end
