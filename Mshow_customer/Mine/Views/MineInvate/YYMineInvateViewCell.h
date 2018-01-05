//
//  YYMineInvateViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMineInvateViewCell : UITableViewCell
@property (nonatomic, assign) BOOL showButton;
@property (nonatomic, copy) void (^invateActionBlock)(void);
@property (nonatomic, copy) void (^seeActionBlock)(void);

@end
