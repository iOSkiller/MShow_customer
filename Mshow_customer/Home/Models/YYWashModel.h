//
//  YYWashModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYWashModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description_content;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) CGFloat cellHeight;

+ (NSArray *)testWashCoatArray;
+ (NSArray *)testWashBedArray;

@end
