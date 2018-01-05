//
//  YYChangeReturnGoodsViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChangeReturnGoodsViewController.h"
#import "YYChangeReturnView.h"
#import "YYImagePickerViewController.h"
#import "YYBigImageViewController.h"
#import "YYSubscribeSuccessViewController.h"

@interface YYChangeReturnGoodsViewController () <YYChangeReturnViewDelegate>
@property (nonatomic, weak) YYChangeReturnView *changeView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation YYChangeReturnGoodsViewController

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退换货";
    self.view.backgroundColor = [UIColor whiteColor];
    YYChangeReturnView *view = [[YYChangeReturnView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _changeView = view;
}

#pragma mark - YYChangeReturnViewDelegate
- (void)executeSubmit
{
    YYSubscribeSuccessViewController *subscribeVC = [YYSubscribeSuccessViewController new];
    subscribeVC.type = YYSubscribeSuccessViewTypeChangeReturnGoods;
    [self.navigationController pushViewController:subscribeVC animated:YES];
}

- (void)executePickImage:(NSUInteger)imageCount
{
    YYImagePickerViewController *pickVC = [[YYImagePickerViewController alloc] init];
    pickVC.finishSelectImageBlock = ^(NSArray *imageArray, NSArray *assetArray) {
        [self.imageArray addObjectsFromArray:imageArray];
        self.changeView.imageArray = self.imageArray;
    };
    pickVC.imagesCount = imageCount;
    [self.navigationController pushViewController:pickVC animated:YES];
}

- (void)executeShowImage:(UIImage *)image index:(NSUInteger)index
{
    
}

- (void)executeChangeImage:(NSArray *)imageArray
{
    [self.imageArray removeAllObjects];
    [self.imageArray addObjectsFromArray:imageArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
