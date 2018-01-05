//
//  YYCartAccountView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYCartAccountViewDelegate <NSObject>
- (void)executePay;
@optional
- (void)executeAllSelected:(BOOL)isAllSelected;

@end

@interface YYCartAccountView : UIView
@property (nonatomic, weak) id <YYCartAccountViewDelegate> delegate;
@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) BOOL isShowSelected;
- (void)setButtonTitle:(NSString *)title;

@end
