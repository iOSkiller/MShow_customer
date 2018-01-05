//
//  YYMineCertifyView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYMineCertifyViewDelegate <NSObject>
- (void)executeCeritfyAction:(NSString *)name code:(NSString *)code;

@end

@interface YYMineCertifyView : UIView

@property (nonatomic, weak) id <YYMineCertifyViewDelegate> delegate;

@end
