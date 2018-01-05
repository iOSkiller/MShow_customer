//
//  YYSelectDurationViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectDurationViewController.h"

@interface YYSelectDurationViewController () <YYSelectRentDurationViewDelegate>
@property (nonatomic, weak) YYSelectRentDurationView *selectView;

@end

@implementation YYSelectDurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setType:(YYSelectRentDurationViewType)type dateForRecieve:(NSDate *)dateForRecieve
{
    self.title = type == YYSelectRentDurationViewTypeDate ? @"收货日期" : @"试穿天数";
    YYSelectRentDurationView *view = [[YYSelectRentDurationView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _selectView = view;
    self.selectView.type = type;
    [self.selectView setDate:dateForRecieve];
}

#pragma mark - YYSelectRentDurationViewDelegate
- (void)executeSureAction:(NSUInteger)duration dateForRecieve:(NSString *)dateForRecieve
{
    if (_didFinishSelectDuration) {
        _didFinishSelectDuration(duration, dateForRecieve);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
