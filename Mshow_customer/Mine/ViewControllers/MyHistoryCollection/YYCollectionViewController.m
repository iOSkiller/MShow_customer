//
//  YYCollectionViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCollectionViewController.h"
#import "YYCollectionChildViewController.h"
#import "YZDisplayViewHeader.h"

@interface YYCollectionViewController ()

@end

@implementation YYCollectionViewController

{
    NSInteger _oldIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
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
    [self setUpRightItem:@"编辑" selectedTitle:@"完成" image:nil highImage:nil target:self action:@selector(editeAction:)];
    
    [self setUpAllViewController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickSelection) name:YZDisplayViewClickOrScrollDidFinshNote object:nil];
    _oldIndex = self.selectIndex;
}

- (void)didClickSelection
{
    YYCollectionChildViewController *childVC = (YYCollectionChildViewController *)self.childViewControllers[_oldIndex];
    childVC.isEditing = NO;
    
    _oldIndex = self.currentIndex;
    UIButton *button = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    button.selected = NO;
}

- (void)editeAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    YYCollectionChildViewController *childVC = (YYCollectionChildViewController *)self.childViewControllers[self.currentIndex];
    childVC.isEditing = sender.selected;
}

- (void)setUpAllViewController
{
    YYCollectionChildViewController *goodsVC = [[YYCollectionChildViewController alloc] init];
    goodsVC.type = YYCollectionChildViewTypeGoods;
    goodsVC.title = @"单品";
    [self addChildViewController:goodsVC];
    
    YYCollectionChildViewController *shopVC = [[YYCollectionChildViewController alloc] init];
    shopVC.type = YYCollectionChildViewTypeShop;
    shopVC.title = @"店铺";
    [self addChildViewController:shopVC];
    
//    YYCollectionChildViewController *brandVC = [[YYCollectionChildViewController alloc] init];
//    brandVC.type = YYCollectionChildViewTypeBrand;
//    brandVC.title = @"品牌";
//    [self addChildViewController:brandVC];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YZDisplayViewClickOrScrollDidFinshNote object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
