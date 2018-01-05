//
//  YYAlertView.h
//  DDFood
//
//  Created by YZ Y on 16/7/11.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYAlertViewType) {
    YYAlertViewTypeNormal,
    YYAlertViewTypeCancelDeal,
    YYAlertViewTypeCertify,
    YYAlertViewTypeGoodsDamageImage,
};

typedef void (^cancelDealBlock)(YYCancelReasonType reasonType);

@interface YYAlertView : UIView
//+ (void)alterViewWithCancelButton:(NSString *)cancelButton sureButton:(NSString *)sureButton target:(id)target cancelAction:(SEL)cancelAction sureAction:(SEL)surelAction;
- (instancetype)initWithType:(YYAlertViewType)type;
- (void)show;
- (void)hide;
@property (nonatomic, copy) cancelDealBlock cancelBlock;
@property (nonatomic, copy) void (^certifyBlock)(NSString *name, NSString *code);
@property (nonatomic, copy) NSArray *goodsDamageImageArray;

@end
