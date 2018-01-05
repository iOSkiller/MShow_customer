//
//  YYQuestionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYQuestionViewDelegate <NSObject>
- (void)executeShowQuestion:(NSString *)questionID;

@end

@interface YYQuestionView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) id <YYQuestionViewDelegate> delegate;

@end
