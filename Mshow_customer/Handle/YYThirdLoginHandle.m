//
//  YYThirdLoginHandle.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/12.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYThirdLoginHandle.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <AlipaySDK/AlipaySDK.h>
#import "AliPayNeedDEF.h"
#import "APAuthInfo.h"
#import "APRSASigner.h"

@implementation YYThirdLoginHandle

+ (NSString *)checkStatus:(SSDKResponseState)state
{
    NSString *result = nil;
    switch (state) {
        case SSDKResponseStateFail:
            result = @"登录失败";
            break;
        case SSDKResponseStateCancel:
            result = @"取消登录";
            break;
        case SSDKResponseStateSuccess:
            result = @"登陆成功";
            break;
        default:
            break;
    }
    return result;
}

+ (void)loginByQQ:(successBlock)successBlock failed:(failedBlock)failed
{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       NSLog(@"dd%@",user.rawData);
                                       NSLog(@"dd%@",user.credential);
                                       successBlock(@"QQ", user.uid, user.nickname, user.icon);
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    failed([self checkStatus:state]);
                                }];
}

+ (void)loginByWeixin:(successBlock)successBlock failed:(failedBlock)failed
{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        associateHandler (user.uid, user, user);
        NSLog(@"uid=%@",user.uid);
        NSLog(@"%@",user.credential);
        NSLog(@"token=%@",user.credential.token);
        NSLog(@"nickname=%@",user.nickname);
        
        successBlock(@"Wechat", user.uid, user.nickname, user.icon);
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        failed([self checkStatus:state]);
    }];
}

+ (void)loginByWeibo:(successBlock)successBlock failed:(failedBlock)failed
{
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             successBlock(@"Weibo", user.uid, user.nickname, user.icon);
         }
         
         else
         {
             failed([self checkStatus:state]);
         }
         
     }];
}

+ (void)loginByAliPay:(successBlock)successBlock failed:(failedBlock)failed
{
    //生成 auth info 对象
    APAuthInfo *authInfo = [APAuthInfo new];
    authInfo.pid = AliPartnerID;
    authInfo.appID = AliAppID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = kAliPayURLScheme;
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner *signer = [[APRSASigner alloc] initWithPrivateKey:AliPartnerPrivKey];
    signedString = [signer signString:authInfoStr withRSA2:NO];
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, @"RSA"];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
    
}
@end
