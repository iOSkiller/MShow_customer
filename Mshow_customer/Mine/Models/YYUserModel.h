//
//  YYUserModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYUserModel : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userCapital;
@property (nonatomic, copy) NSString *userMobile;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *headImgUrl;
@property (nonatomic, copy) NSString *vipLevel;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *bonusScore;
@property (nonatomic, copy) NSString *authentication;
@property (nonatomic, copy) NSString *credit;
@property (nonatomic, copy) NSString *recordState;

@end
