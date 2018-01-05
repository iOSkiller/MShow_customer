//
//  YYAuthcodeView.h
//  DDFood
//
//  Created by YZ Y on 16/6/17.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YYAuthcodeView : UIView
@property (nonatomic, copy)NSString *authCodeStr;//验证码字符串
- (void)refresh;

@end
