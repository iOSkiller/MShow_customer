//
//  YYMineInfoViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInfoViewController.h"
#import "YYMineInfoView.h"
#import "YYTakePhotoHandle.h"
#import "YYBottomSelectView.h"
#import "YYActionSheet.h"
#import "YYChangeInfoViewController.h"

@interface YYMineInfoViewController () <YYMineInfoViewDelegate>
@property (nonatomic, weak) YYMineInfoView *infoView;

@end

@implementation YYMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    YYMineInfoView *view = [[YYMineInfoView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    self.infoView = view;
    WS(ws);
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(ws.view.safeAreaInsets);
        } else {
            make.edges.equalTo(ws.view);
        }
    }];
}

#pragma mark - YYMineInfoViewDelegate
- (void)gotoDetail:(YYMineInfoType)type
{
    switch (type) {
        case YYMineInfoTypeIcon:
        {
            if ([YYTakePhotoHandle checkAuthStatus]) {
                [YYTakePhotoHandle getPicture:^(UIImage *image) {
                    [self.infoView setIcon:image];
                }];
            }
        }
            break;
        case YYMineInfoTypeNickname:
        case YYMineInfoTypePhone:
        case YYMineInfoTypeHeight:
        {
            YYChangeInfoViewController *changeInfoVC = [YYChangeInfoViewController new];
            changeInfoVC.type = type;
            WS(weakSelf);
            changeInfoVC.didFinishChangeInfoBlock = ^(NSString *info) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                [strongSelf.infoView updateInfo:info type:type];
            };
            [self.navigationController pushViewController:changeInfoVC animated:YES];
            break;
        }
        case YYMineInfoTypeLevel:
            break;
        case YYMineInfoTypeGender:
        {
            YYActionSheet *sheet = [[YYActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"男", @"女"]];
            WS(weakSelf);
            sheet.otherActionBlock = ^(NSInteger index) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                switch (index) {
                    case 0:
                        [strongSelf.infoView setGender:@"男"];
                        break;
                    case 1:
                        [strongSelf.infoView setGender:@"女"];
                        break;
                    default:
                        break;
                }
            };
            [sheet show];
            break;
        }
        case YYMineInfoTypeBirthday:
        {
            YYBottomSelectView *selectBirthDayView = [[YYBottomSelectView alloc] initWithFrame:self.view.bounds type:YYBottomSelectViewTypeBirthDay];
            [selectBirthDayView show];
            WS(weakSelf);
            selectBirthDayView.didSelectBirthDayBlock = ^(NSString *birthDay) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                [strongSelf.infoView setBirthDay:birthDay];
            };
            break;
        }
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
