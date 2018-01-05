//
//  YYCommentDealViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentDealViewController.h"
#import "YYCommentDealView.h"
#import "YYImagePickerViewController.h"
#import "YYBigImageViewController.h"
#import "YYCommentModel.h"
#import "YYCommentSuccessViewController.h"

@interface YYCommentDealViewController () <YYCommentDealViewDelegate>
@property (nonatomic, weak) YYCommentDealView *commentView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation YYCommentDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表评价";
    self.fd_interactivePopDisabled = YES;
    YYCommentDealView *view = [[YYCommentDealView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _commentView = view;
    _imageArray = [NSMutableArray array];
    
    [self setUpLeftItem:nil selectedTitle:nil image:@"img_arrow_left" highImage:@"img_arrow_left" target:self action:@selector(backAction)];
}

- (void)backAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消发布吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WS(weakSelf);
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续发布" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - YYCommentDealViewDelegate
- (void)executeShowImage:(UIImage *)image index:(NSUInteger)index
{
    
}

- (void)executePickImage:(NSUInteger)imagesCount
{
    YYImagePickerViewController *pickerVC = [[YYImagePickerViewController alloc] init];
    pickerVC.maxImagesCount = 3;
    pickerVC.imagesCount = imagesCount;
    WS(weakSelf);
    pickerVC.finishSelectImageBlock = ^(NSArray *imageArray, NSArray *assetArray) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.imageArray addObjectsFromArray:imageArray];
        strongSelf.commentView.imageArray = self.imageArray;
    };
    [self.navigationController pushViewController:pickerVC animated:YES];
}

- (void)executeChangeImage:(NSArray *)imageArray
{
    [self.imageArray removeAllObjects];
    [self.imageArray addObjectsFromArray:imageArray];
}

- (void)executeSubmietComment:(YYCommentModel *)commentModel
{
    if (_didFinishCommentBlock) {
        _didFinishCommentBlock(_dealModel);
    }
    [self.navigationController pushViewController:[YYCommentSuccessViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
