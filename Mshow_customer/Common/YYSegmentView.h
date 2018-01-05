//
//  YYSegmentView.h
//  DDFood
//
//  Created by YZ Y on 16/6/22.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYSegmentViewDelegate <NSObject>

- (void)clickSelectionID:(NSString *)selectionID ascending:(BOOL)ascending;

@end

@interface YYSegmentView : UIView
- (instancetype)initWithFrame:(CGRect)frame selections:(NSArray *)selectionsArr;
- (instancetype)initWithFrame:(CGRect)frame leftMargin:(CGFloat)leftMargin magrin:(CGFloat)margin selections:(NSArray *)selectionsArr;

- (void)refresh;
@property (nonatomic, weak) id <YYSegmentViewDelegate> delegate;
- (void)setSeparator:(UIColor *)separatorColor height:(CGFloat)height;


@end
