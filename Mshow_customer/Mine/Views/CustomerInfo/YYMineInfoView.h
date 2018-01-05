//
//  YYMineInfoView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseView.h"

@protocol YYMineInfoViewDelegate <NSObject>
- (void)gotoDetail:(YYMineInfoType)type;

@end

@interface YYMineInfoView : YYBaseView
@property (nonatomic, weak) id <YYMineInfoViewDelegate> delegate;
- (void)setIcon:(UIImage *)image;
- (void)setBirthDay:(NSString *)birthDay;
- (void)setHeight:(NSString *)height;
- (void)setGender:(NSString *)gender;
- (void)updateInfo:(NSString *)info type:(YYMineInfoType)type;

@end
