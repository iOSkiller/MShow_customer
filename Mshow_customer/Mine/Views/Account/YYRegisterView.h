//
//  YYRegisterView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYRegisterViewType) {
    YYRegisterViewTypeRegister,
    YYRegisterViewTypeResetCode,
};

@protocol YYRegisterViewDelegate <NSObject>
- (void)executeSureAction:(NSString *)phone password:(NSString *)password code:(NSString *)code;
- (void)executeShowProtocol;
- (void)executeSendPhoneCode:(NSString *)phone;

@end

@interface YYRegisterView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(YYRegisterViewType)type;
@property (nonatomic, weak) id <YYRegisterViewDelegate> delegate;
- (void)beginTimer;

@end
