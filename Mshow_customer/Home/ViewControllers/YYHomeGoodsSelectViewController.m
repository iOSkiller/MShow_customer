//
//  YYHomeGoodsSelectViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeGoodsSelectViewController.h"
#import "YYSelectChildViewController.h"

@interface YYHomeGoodsSelectViewController ()

@end

@implementation YYHomeGoodsSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isfullScreen = NO;
    self.scrollEnable = NO;
    //设置选项属性
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = YYTextColor;
        *selColor = mRGBToColor(0xf46060);
        *titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        *titleHeight = RELATIVE_WIDTH(80);
    }];
    //设置下划线
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *isUnderLineDelayScroll = NO;
        *isUnderLineEqualTitleWidth = YES;
        *underLineH = RELATIVE_WIDTH(2);
        *underLineColor = YYGlobalColor;
    }];
    
    switch (_dataType) {
        case YYSelectChildViewDataTypeNew:
            self.title = @"今日新品";
            break;
        case YYSelectChildViewDataTypeHot:
            self.title = @"今日爆品";
            break;
        case YYSelectChildViewDataTypeTry:
            self.title = @"完美体验";
            break;
        default:
            break;
    }
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"img_table"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"img_collection"] forState:UIControlStateSelected];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.frame = CGRectMake(0, 0, RELATIVE_WIDTH(64), RELATIVE_WIDTH(44));
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, 0);
    [rightBtn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self setUpAllViewController];

}

- (void)setUpAllViewController
{
    YYSelectChildViewController *womenVC = [[YYSelectChildViewController alloc] init];
    womenVC.isFullScreen = YES;
    womenVC.type = YYSelectChildViewTypeWomen;
    womenVC.dataType = _dataType;
    womenVC.title = @"女装";
    [self addChildViewController:womenVC];
    
    YYSelectChildViewController *manVC = [[YYSelectChildViewController alloc] init];
    manVC.isFullScreen = YES;
    manVC.type = YYSelectChildViewTypeMan;
    manVC.dataType = _dataType;
    manVC.title = @"男装";
    [self addChildViewController:manVC];
    
    YYSelectChildViewController *childVC = [[YYSelectChildViewController alloc] init];
    childVC.isFullScreen = YES;
    childVC.type = YYSelectChildViewTypeChild;
    childVC.dataType = _dataType;
    childVC.title = @"童装";
    [self addChildViewController:childVC];
    
}

- (void)changeType:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    YYSelectChildViewController *vc = (YYSelectChildViewController *)self.childViewControllers[self.currentIndex];
    vc.isTableView = sender.isSelected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
