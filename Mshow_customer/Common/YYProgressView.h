//
//  YYProgressView.h
//  DDFood
//
//  Created by YZ Y on 16/12/31.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYProgressView : UIView
/**进度颜色*/
@property(nonatomic, retain) UIColor* progressTintColor ;


/**轨道颜色*/
@property(nonatomic, retain) UIColor* trackTintColor ;

/**轨道宽度*/
@property (nonatomic,assign) float lineWidth;

/**中间图片*/
@property (nonatomic,strong) UIImage *centerImage;

/**进度*/
@property (nonatomic,assign) float progressValue;

/**提示标题*/
@property (nonatomic,strong) NSString *promptTitle;
/**开启动画*/
- (void)startAnimation;
/**停止动画*/
- (void)stopAnimation;

/**隐藏消失*/
- (void)hide;

@end