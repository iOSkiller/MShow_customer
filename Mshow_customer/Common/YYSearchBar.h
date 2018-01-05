//
//  YYSearchBar.h
//  DDFood
//
//  Created by YZ Y on 16/6/3.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

typedef NS_ENUM(NSInteger, YYSearchBarType) {
    YYSearchBarTypeLabel,
    YYSearchBarTypeNavi,
    YYSearchBarTypeTextField
};

#import <UIKit/UIKit.h>

@interface YYSearchBar : UIView
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, assign) YYSearchBarType type;
@property (nonatomic, assign) BOOL hideLine;
@property (nonatomic, assign) BOOL leftImage;
@property (nonatomic, assign) BOOL blackStyle;
@property (nonatomic, assign) BOOL fullStyle;
@property (nonatomic, assign) BOOL isFull;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) void(^endEdite)(NSString *text);
@property (nonatomic, copy) void(^showSearchViewBlock)(void);
@property (nonatomic, copy) void(^didChangeTextBlock)(NSString *text);

@end
