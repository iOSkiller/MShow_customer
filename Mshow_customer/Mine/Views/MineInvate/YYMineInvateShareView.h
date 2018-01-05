//
//  YYMineInvateShareView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMineInvateShareView : UIView
//@property (nonatomic, copy) void (^shareBlock)(YYShareType shareType);
@property (nonatomic, copy) NSDictionary *contentDic;
- (void)show;
- (void)hide;


@end
