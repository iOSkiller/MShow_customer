//
//  YYMessageModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YYMessageType) {
    YYMessageTypeDelivery,
    YYMessageTypeNews,
};

@interface YYMessageModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) YYMessageType messageType;
@property (nonatomic, assign) YYDealStatusType dealType;

+ (NSArray *)testDataArray;

@end
