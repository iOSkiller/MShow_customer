//
//  YYBaseTableView.m
//  DDFood
//
//  Created by YYZ on 2017/9/28.
//  Copyright © 2017年 YZ Y. All rights reserved.
//

#import "YYBaseTableView.h"

@implementation YYBaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        if (@available(iOS 11.0, *)) {
            //iOS11 后需设置一下3个属性为0.0
            self.estimatedRowHeight = 0.0;
            self.estimatedSectionFooterHeight = 0.0;
            self.estimatedSectionHeaderHeight = 0.0;
        }
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.tableFooterView = [UIView new];
        [self setSeparatorColor:YYSeparatorColor];
    }
    return self;
}

@end
