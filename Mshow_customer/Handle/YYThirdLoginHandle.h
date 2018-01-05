//
//  YYThirdLoginHandle.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/12.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseHandle.h"

typedef void (^successBlock)(NSString *platName, NSString *userID, NSString *nickName, NSString *headURL);
typedef void (^failedBlock)(NSString *msg);

@interface YYThirdLoginHandle : YYBaseHandle
/**qq登录*/
+ (void)loginByQQ:(successBlock)successBlock failed:(failedBlock)failed;
/**微信登录*/
+ (void)loginByWeixin:(successBlock)successBlock failed:(failedBlock)failed;
/**微博登录*/
+ (void)loginByWeibo:(successBlock)successBlock failed:(failedBlock)failed;
/**支付宝登录*/
+ (void)loginByAliPay:(successBlock)successBlock failed:(failedBlock)failed;


@end
