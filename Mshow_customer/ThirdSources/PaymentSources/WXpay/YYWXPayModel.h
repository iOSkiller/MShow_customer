//
//  YYWXPayModel.h
//  DDFood
//
//  Created by YZ Y on 17/1/22.
//  Copyright © 2017年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYWXPayModel : NSObject

@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *packagestr;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *sign;

@end
