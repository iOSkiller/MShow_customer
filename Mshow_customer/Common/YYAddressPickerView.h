//
//  YYAddressPickerView.h
//  DDFood
//
//  Created by YZ Y on 16/7/12.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YYAddressPickerViewHeight RELATIVE_WIDTH(428)

@protocol YYAddressPickerViewDelegate <NSObject>

@optional
- (void)getCity:(NSString *)cityString showString:(NSString *)showString;

- (void)clickSureButtonShowProvince:(NSString *)province city:(NSString *)city district:(NSString *)district;

- (void)getProvince:(NSString *)province city:(NSString *)city district:(NSString *)district;

@end

@interface YYAddressPickerView : UIView
@property (nonatomic, weak) id <YYAddressPickerViewDelegate> delegate;
- (void)showPicker;
- (void)hidePicker;
- (void)cityStringHaveNoDataHideView;

@end
