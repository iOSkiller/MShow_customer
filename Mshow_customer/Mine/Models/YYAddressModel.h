//
//  YYAddressModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYAddressModel : NSObject
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString *addressID;
@property (nonatomic, assign) BOOL isDefault;
+ (NSArray *)testDataArray;

@end
