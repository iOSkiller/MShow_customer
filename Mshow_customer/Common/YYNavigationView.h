//
//  YYNavigationView.h
//  DDFood
//
//  Created by YZ Y on 16/6/3.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYNavigationViewDelegate <NSObject>

- (void)clickRightButton:(UIButton *)button;
- (void)clickLeftButton;


@optional
- (void)clickSegement:(NSString *)selectionID ascending:(BOOL)ascending;
- (void)searchText:(NSString *)text;
- (void)showSearchView;

@end

@interface YYNavigationView : UIView
@property (nonatomic, weak) id <YYNavigationViewDelegate> delegate;
@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, assign) BOOL hideKeyboard;
@property (nonatomic, assign) BOOL hideLine;
@property (nonatomic, assign) BOOL hideLeftButton;
@property (nonatomic, assign) BOOL searchBarHaveCorner;
@property (nonatomic, assign) BOOL haveBottomLine;
@property (nonatomic, assign) BOOL haveSegment;
@property (nonatomic, assign) BOOL hide;
@property (nonatomic, assign) BOOL blackStyle;
- (void)refresh;

@end
