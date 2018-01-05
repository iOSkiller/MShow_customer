//
//  YYActionSheet.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/5.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYActionSheet : UIView
- (instancetype _Nullable)initWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles;
@property (nonatomic, copy) void (^ _Nullable otherActionBlock)(NSInteger index);
@property (nonatomic, copy) void (^ _Nullable cancelActionBlock)(void);
@property (nonatomic, copy) void (^ _Nullable destructiveActionBlock)(void);
- (void)show;

@end
