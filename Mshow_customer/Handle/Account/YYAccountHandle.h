//
//  YYAccountHandle.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/18.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYAccountHandle : YYBaseHandle
/**密码登录*/
+ (void)executeLogin:(NSString *)longinName password:(NSString *)password success:(SuccessedBlock)success failed:(failed)failed;
/**手机注册*/
+ (void)executeRegister:(NSString *)phone password:(NSString *)password code:(NSString *)code success:(SuccessedBlock)success failed:(failed)failed;
/**发送注册手机验证码*/
+ (void)executeSendRegisterPhoneCode:(NSString *)phone success:(SuccessedBlock)success failed:(failed)failed;
/**发送重置密码手机验证码*/
+ (void)executeSendResetPasswordPhoneCode:(NSString *)phone success:(SuccessedBlock)success failed:(failed)failed;
/**重置密码*/
+ (void)executeResetPassword:(NSString *)phone password:(NSString *)password code:(NSString *)code success:(SuccessedBlock)success failed:(failed)failed;

@end
