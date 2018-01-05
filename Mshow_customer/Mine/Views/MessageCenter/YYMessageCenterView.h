//
//  YYMessageCenterView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYMessageModel;

@protocol YYMessageCenterViewDelegate <NSObject>
- (void)executeMessageDetail:(YYMessageModel *)messageModel;

@end

@interface YYMessageCenterView : UIView
@property (nonatomic, weak) id <YYMessageCenterViewDelegate> delegate;
@property (nonatomic, copy) NSArray *messageArray;

@end
