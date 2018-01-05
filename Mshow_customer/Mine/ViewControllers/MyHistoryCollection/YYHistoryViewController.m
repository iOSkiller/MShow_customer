//
//  YYHistoryViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryViewController.h"
//#import "YYHistoryView.h"
#import "YYHistoryTableView.h"
#import "YYHistoryFunctionView.h"
#import "YYGoodsModel.h"
#import "YYHistoryModel.h"

@interface YYHistoryViewController () <YYHistoryTableViewDelegate, YYHistoryFunctionViewDelegate>
//@property (nonatomic, weak) YYHistoryView *historyView;
@property (nonatomic, weak) YYHistoryTableView *historyView;
@property (nonatomic, weak) YYHistoryFunctionView *functionView;
@property (nonatomic, weak) UIButton *editeButton;
@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation YYHistoryViewController

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (YYHistoryFunctionView *)functionView {
    if (!_functionView) {
        YYHistoryFunctionView *view = [[YYHistoryFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT, WIN_WIDTH, RELATIVE_WIDTH(100))];
        view.delegate = self;
        [self.view addSubview:view];
        _functionView = view;
    }
    return _functionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"足迹";
    self.view.backgroundColor = [UIColor whiteColor];
//    UIBarButtonItem *clearItem = [UIBarButtonItem itemWithTitle:@"清除" selectedTitle:@"" image:nil highImage:nil target:self action:@selector(clearAction)];
    
    UIBarButtonItem *editeItem = [UIBarButtonItem itemWithTitle:@"清除" selectedTitle:@"完成" image:nil highImage:nil target:self action:@selector(editeAction:)];
    
   
    [self setUpRightItems:@[editeItem]];
    
    YYHistoryTableView *historyView = [[YYHistoryTableView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    historyView.delegate = self;
    [self.view addSubview:historyView];
    _historyView = historyView;
    
    [self functionView];
    if ((mAppDelegate).iPhoneX) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_MARGIN_BOTTOM, WIN_WIDTH, iPhone_MARGIN_BOTTOM)];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        
    }
    self.historyView.dataArray = [YYHistoryModel testDataArray];
}

//- (void)clearAction
//{
//    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除记录" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.historyView.dataArray = @[];
//
//    }];
//    [alertControl addAction:cancelAction];
//    [alertControl addAction:sureAction];
//    [self presentViewController:alertControl animated:YES completion:nil];
//}

- (void)editeAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.historyView.isEditing = sender.isSelected;
//    self.historyView.mj_h = sender.selected ? (WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - self.functionView.mj_h) : (WIN_HEIGHT - iPhone_ProtraitDisableViewHeight);
    WS(ws);
    if (sender.isSelected) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.functionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.bottom.left.right.mas_equalTo(ws.view.safeAreaInsets);
                } else {
                    make.bottom.left.right.equalTo(ws.view);
                }
                make.height.mas_equalTo(RELATIVE_WIDTH(100));
            }];
            [self.historyView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.top.left.right.mas_equalTo(ws.view.safeAreaInsets);
                } else {
                    make.top.left.right.equalTo(ws.view);
                }
                make.bottom.equalTo(self.functionView.mas_top);
            }];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            [self.functionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.top.mas_equalTo(ws.view.mas_bottom);
                    make.left.right.mas_equalTo(ws.view.safeAreaInsets);
                } else {
                    make.left.right.equalTo(ws.view);
                    make.top.equalTo(ws.view.mas_bottom);
                }
                make.height.mas_equalTo(RELATIVE_WIDTH(100));
            }];
            [self.historyView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.edges.mas_equalTo(ws.view.safeAreaInsets);
                } else {
                    make.edges.equalTo(ws.view);
                }
            }];
        }];
    }
}

#pragma mark - YYHistoryFunctionViewDelegate
- (void)executeDelete
{
    [self.historyView deleteSelectedGoods];
}

#pragma mark - YYHistoryTableViewDelegate
- (void)tableViewShowShopDetail:(NSString *)shopID
{
    [self showShopDetail:@""];
}

- (void)tableViewShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsID];
}


//#pragma mark - YYHistoryViewDelegate
//- (void)executeSelectGoods:(NSArray *)selectGoodsArray
//{
//    
//}
//
//- (void)executeLikeGoods:(YYGoodsModel *)goodsModel isLike:(BOOL)isLike
//{
//    
//}
//
//- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
//{
//    [self showGoodsDetail:goodsModel.goodsID];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
