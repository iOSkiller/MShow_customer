//
//  YYPayMentHandle.m
//  DDFood
//
//  Created by YZ Y on 16/8/9.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYPayMentHandle.h"
#import "YYWeixinPayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "YYWXPayModel.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"

@implementation YYPayMentHandle
+ (void)executePayUseWeChatPayWithPrepay_id:(NSString *)prepay_id nonce_str:(NSString *)nonce_str Success:(SuccessedBlock)success failed:(failed)failed
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",str);
    //调起微信支付···
    PayReq *req             = [[PayReq alloc] init];
    req.partnerId           = MCH_ID;
    req.prepayId            = [NSString stringWithFormat:@"%@",prepay_id];
    req.nonceStr            = [NSString stringWithFormat:@"%@",nonce_str];
    req.timeStamp           = [str intValue];
    req.package             = @"Sign=WXpay";
    //创建支付签名对象
    YYWeixinPayManager *req1 = [[YYWeixinPayManager alloc] init];
    //初始化支付签名对象
    [req1 init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req1 setKey:PARTNER_ID];
    //第二次签名参数列表
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject: APP_ID        forKey:@"appid"];
    [signParams setObject: @"Sign=WXpay" forKey:@"package"];
    [signParams setObject: MCH_ID        forKey:@"partnerid"];
    [signParams setObject: [NSString stringWithFormat:@"%@", nonce_str]   forKey:@"noncestr"];
    [signParams setObject: [NSString stringWithFormat:@"%d", str.intValue]   forKey:@"timestamp"];
    [signParams setObject: [NSString stringWithFormat:@"%@", prepay_id]     forKey:@"prepayid"];
    //生成签名
    NSString *signStr = [req1 createMd5Sign:signParams];
    MJExtensionLog(@"%@", signStr);
    req.sign = signStr;
    MJExtensionLog(@"%@", req);
    
    [WXApi sendReq:req];
}

//支付宝支付
+ (void)executePayUseAliPayWithOrderId:(NSString *)orderId totalMoney:(NSString *)totalMoney payTitle:(NSString *)payTitle Success:(SuccessedBlock)success failed:(failed)failed
{
    
    NSString *appID = AliAppID;
    NSString *rsa2PrivateKey = AliPartnerPrivKey;
    NSString *rsaPrivateKey = nil;
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    /**回调地址*/
    order.notify_url = AliNotifyURL;
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1) ? @"RSA2" : @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    /**商品描述*/
    order.biz_content.body = @"Mshow";
    //商品的标题/交易标题/订单标题/订单关键字等
    order.biz_content.subject = payTitle;
//    order.biz_content.subject = resultStr;
    //订单ID（由商家自行制定）
    order.biz_content.out_trade_no = [NSString stringWithFormat:@"%@", orderId];
    //超时时间设置
    order.biz_content.timeout_express = @"30m";
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    /**商户ID*/
    order.biz_content.seller_id = AliSellerID;
    
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    MJExtensionLog(@"orderSpec = %@", orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner *signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1) ? rsa2PrivateKey : rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = kAliPayURLScheme;
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([[resultDic objectForKey:@"resultStatus"] isEqual:@"9000"]) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_FAILED];
            }
            MJExtensionLog(@"reslut = %@", resultDic);
        }];
    }
}

+ (void)executeDeal:(NSString *)orderID body:(NSString *)body price:(NSString *)price success:(SuccessedBlock)success failed:(failed)failed
{
    [YYHttpHandle POST:@"http://101.132.67.18:8080/mshow_mobile/pay/unifiedorder" params:@{@"body": body, @"price": price, @"orderId": orderID} success:^(id json) {
        NSDictionary *dict = [json mj_JSONObject];
        if ([dict[@"code"] integerValue] == 200) {
            YYWXPayModel *model = [YYWXPayModel mj_objectWithKeyValues:dict[@"msg"]];
            success(model);
        } else {
            failed(dict[@"msg"]);
        }
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode: %d errorCode:%d", statusCode, errorCode);
        failed(@(statusCode));
    }];
}

+ (void)executeGetAlipayOrderNum:(SuccessedBlock)success failed:(failed)failed
{
    [YYHttpHandle POST:@"http://101.132.67.18:8080/mshow_mobile/alipayAPP/pay" params:@{} success:^(id json) {
        MJExtensionLog(@"%@", json);
    } failure:^(int statusCode, int errorCode) {
        MJExtensionLog(@"statusCode: %d errorCode:%d", statusCode, errorCode);
    }];
}

@end
