//
//  YYAccountHandle.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/18.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYAccountHandle.h"
#import "YYUserModel.h"
#import "YYUserDefaultHandle.h"

@implementation YYAccountHandle
+ (void)executeLogin:(NSString *)longinName password:(NSString *)password success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"userAcc": longinName,
                          @"userPwd": [NSString getMD5_32bitString:password]
                          };
    [YYHttpHandle POST:AppendString(BaseURL, login) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"status"] boolValue]) {
            YYUserModel *model = [YYUserModel mj_objectWithKeyValues:dict[@"model"]];
            [YYUserDefaultHandle updateUserDefaultInfo:[model mj_keyValues]];
            success(model);
        } else {
            failed(dict[@"message"]);
        }
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode: %d, errorCode:%d", statusCode, errorCode);
        failed(@"请稍后再试");
    }];
}

+ (void)executeRegister:(NSString *)phone password:(NSString *)password code:(NSString *)code success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"verifyCode": code,
                          @"passwd": [NSString getMD5_32bitString:password],
                          @"userMobile": phone,
                          };
    [YYHttpHandle POST:AppendString(BaseURL, registerAccount) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"status"] boolValue]) {
            success(@"注册成功");
        } else {
            failed(dict[@"message"]);
        }
        MJExtensionLog(@"%@", dict);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%d errorCode:%d", statusCode, errorCode);
    }];
}

+ (void)executeSendRegisterPhoneCode:(NSString *)phone success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"userMobile": phone};
    [YYHttpHandle POST:AppendString(BaseURL, registerPhoneCode) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        MJExtensionLog(@"%@", dict);
        if ([dict[@"status"] boolValue]) {
            success(@"发送成功");
        } else {
            failed(dict[@"message"]);
        }
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%d errorCode:%d", statusCode, errorCode);
        failed(@"请稍后再试");
    }];
}

+ (void)executeSendResetPasswordPhoneCode:(NSString *)phone success:(SuccessedBlock)success failed:(failed)failed

{
    NSDictionary *dic = @{@"userMobile": phone};
    [YYHttpHandle POST:AppendString(BaseURL, resetPasswordPhoneCode) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        MJExtensionLog(@"%@", dict);
        if ([dict[@"status"] boolValue]) {
            success(@"发送成功");
        } else {
            failed(dict[@"message"]);
        }
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode:%d errorCode:%d", statusCode, errorCode);
        failed(@"请稍后再试");
    }];
}

+ (void)executeResetPassword:(NSString *)phone password:(NSString *)password code:(NSString *)code success:(SuccessedBlock)success failed:(failed)failed
{
    NSDictionary *dic = @{@"verifyCode": code,
                          @"userPwd": [NSString getMD5_32bitString:password],
                          @"userMobile": phone,
                          };
    [YYHttpHandle POST:AppendString(BaseURL, resetPassword) params:dic success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"status"] boolValue]) {
            success(@"修改成功");
        } else {
            failed(dict[@"message"]);
        }
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode: %d, errorCode:%d", statusCode, errorCode);
        failed(@"请稍后再试");
    }];
}

@end
