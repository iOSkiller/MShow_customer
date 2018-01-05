//
//  YYWalletQuestionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/12.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYWalletQuestionView : UIView
@property (nonatomic, copy) void (^showQuestionDetailBlock)(YYWalletQuestionType questionType);

@end
