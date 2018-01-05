//
//  YYTabBar.h
//  DDFood
//
//  Created by YZ Y on 16/6/2.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYTabBarDelegate <NSObject>

- (void)clickActivityAction;

@end

@interface YYTabBar : UITabBar
@property (nonatomic, weak) id <YYTabBarDelegate> customDelegate;
@end
