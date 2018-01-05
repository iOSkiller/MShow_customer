//
//  YYShopGoodsKindModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYShopGoodsKindModel : NSObject
@property (nonatomic, copy) NSString *kind_content;
@property (nonatomic, copy) NSString *kind_id;
@property (nonatomic, copy) NSString *type_content;
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSArray *kindArray;
@property (nonatomic, assign) CGFloat cellHeight;

+ (NSArray *)testDataArray;
+ (NSArray *)testJacketArray;
+ (NSArray *)testSkirtArray;
+ (NSArray *)testCoatArray;
+ (NSArray *)testTrousersArray;

@end
