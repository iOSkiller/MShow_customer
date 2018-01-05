//
//  YYMessageCenterViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMessageCenterViewController.h"
#import "YYMessageModel.h"
#import "YYMessageCenterView.h"

@interface YYMessageCenterViewController () <YYMessageCenterViewDelegate>
@property (nonatomic, weak) YYMessageCenterView *centerView;

@end

@implementation YYMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    YYMessageCenterView *centerView = [[YYMessageCenterView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    centerView.delegate = self;
    [self.view addSubview:centerView];
    _centerView = centerView;
    WS(ws);
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(ws.view.safeAreaInsets);
        } else {
            make.edges.equalTo(ws.view);
        }
    }];
    self.centerView.messageArray = [YYMessageModel testDataArray];
}

#pragma mark - YYMessageCenterViewDelegate
- (void)executeMessageDetail:(YYMessageModel *)messageModel
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
