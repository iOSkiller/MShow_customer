//
//  YYQuestionModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/21.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYQuestionModel : NSObject
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;
+ (NSArray *)walletQuestionArray;

@end
