//
//  YYThirdLoginView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYThirdLoginView : UIView
@property (nonatomic, copy) void(^loginSuccessBlock)(NSString *platName, NSString *userID, NSString *nickName, NSString *headURL);
@property (nonatomic, copy) void (^loginFailedBlock)(NSString *message);

@end
