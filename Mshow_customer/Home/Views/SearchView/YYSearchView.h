//
//  YYSearchView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSearchModel;

@protocol YYSearchViewDelegate <NSObject>
- (void)executeDidSelectSearchResult:(YYSearchModel *)searchModel;
- (void)executeDeleteSearchHistory;
@end

@interface YYSearchView : UIView
@property (nonatomic, assign) BOOL isSearching;
@property (nonatomic, weak) id <YYSearchViewDelegate> delegate;
- (void)deleteSearchHistory;

@end
