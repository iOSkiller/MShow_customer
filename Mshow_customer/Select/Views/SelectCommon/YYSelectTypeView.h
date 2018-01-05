//
//  YYSelectTypeView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYSelectTypeViewDelegate <NSObject>
- (void)shouldShowSelectionView:(BOOL)show index:(NSInteger)index;

@end

@interface YYSelectTypeView : UIView
- (instancetype)initWithFrame:(CGRect)frame selections:(NSArray *)selectionsArr;
@property (nonatomic, weak) id <YYSelectTypeViewDelegate> delegate;
- (void)refresh;

@end
