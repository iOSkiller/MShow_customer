//
//  YYConsumerdetailsViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYConsumerdetailsViewController.h"
#import "YYConsumerdetailsView.h"

@interface YYConsumerdetailsViewController ()
@property (nonatomic, weak) YYConsumerdetailsView *detailView;

@end

@implementation YYConsumerdetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费明细";
    self.view.backgroundColor = YYSeparatorColor;
    YYConsumerdetailsView *view = [[YYConsumerdetailsView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    [self.view addSubview:view];
    _detailView = view;
    WS(ws);
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(ws.view.safeAreaInsets);
        } else {
            make.edges.equalTo(ws.view);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
