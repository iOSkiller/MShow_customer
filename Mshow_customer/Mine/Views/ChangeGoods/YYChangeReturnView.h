//
//  YYChangeReturnView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYChangeReturnViewDelegate <NSObject>
- (void)executeSubmit;
- (void)executePickImage:(NSUInteger)imageCount;
- (void)executeShowImage:(UIImage *)image index:(NSUInteger)index;
- (void)executeChangeImage:(NSArray *)imageArray;

@end

@interface YYChangeReturnView : UIView
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, weak) id <YYChangeReturnViewDelegate> delegate;

@end
