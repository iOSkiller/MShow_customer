//
//  YYQuestionModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/21.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYQuestionModel.h"

@implementation YYQuestionModel
+ (NSArray *)walletQuestionArray
{
    YYQuestionModel *model1 = [YYQuestionModel new];
    model1.question = @"什么是账户余额？";
    model1.answer = @"账户余额是用户在M秀的预付资金，支持充值，提现等功能。\n充值：使用储蓄卡向余额充值。\n提现：将余额里的资金转到储蓄卡。";
    YYQuestionModel *model2 = [YYQuestionModel new];
    model2.question = @"充值限制";
    model2.answer = @"当次最多可充值金额是由银行卡支付限额和充值业务限额综合决定。充值业务本身限额为1万/1万/3万(单笔/单日/单月),银行卡每次可使用的限额由风控限额和通道限额构成;当提示您“输入金额已超过限额”,您可更改充值金额再次尝试充值。";
    YYQuestionModel *model3 = [YYQuestionModel new];
    model3.question = @"提现限制";
    model3.answer = @"当次最多可提现金额是由可提现余额和提现业务本身限额综合决定提现业务本身限额为5万/5万/5万(单笔/单日/单月),当提示您输入金额已超过提现业务限额”,您分多次进行提现。";
    
    YYQuestionModel *model4 = [YYQuestionModel new];
    model4.question = @"提现到账时间";
    model4.answer = @"正常情况下,提现资金会在2小时内到账,特殊情况(如银行系统异常)除外;若您超过两小时仍未收到提现资金,请耐心等待;提现失败时资金将退回到余额里。";
    
    return @[model1, model2, model3, model4];
}
@end
