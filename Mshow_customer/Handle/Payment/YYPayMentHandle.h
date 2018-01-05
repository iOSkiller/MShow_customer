//
//  YYPayMentHandle.h
//  DDFood
//
//  Created by YZ Y on 16/8/9.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYBaseHandle.h"

@interface YYPayMentHandle : YYBaseHandle

/**
 微信支付

 @param prepay_id 后台返回的预支付交易会话ID
 @param nonce_str 后台返回的随机字符串
 */
+ (void)executePayUseWeChatPayWithPrepay_id:(NSString *)prepay_id
                               nonce_str:(NSString *)nonce_str
                                 Success:(SuccessedBlock)success
                                  failed:(failed)failed;

+ (void)executePayUseAliPayWithOrderId:(NSString *)orderId
                              totalMoney:(NSString *)totalMoney
                                payTitle:(NSString *)payTitle
                                 Success:(SuccessedBlock)success
                                  failed:(failed)failed;
+ (void)executeDeal:(NSString *)orderID body:(NSString *)body price:(NSString *)price success:(SuccessedBlock)success
             failed:(failed)failed;
+ (void)executeGetAlipayOrderNum:(SuccessedBlock)success
                        failed:(failed)failed;
@end
