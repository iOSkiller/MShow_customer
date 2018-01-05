//
//  YYMineInvateShareView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateShareView.h"
#import "YYMineInvateShareViewCell.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>

static NSString *const cellID = @"YYMineInvateShareViewCellID";
static NSString *const footerID = @"YYMineInvateShareViewFooterID";

@interface YYMineInvateShareView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *imageArray;

@end

@implementation YYMineInvateShareView

{
    CGFloat _originalY;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"微信好友", @"朋友圈", @"新浪微博", @"QQ"];
    }
    return _titleArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"login_WeChat", @"img_Circleoffriends", @"img_microblogs", @"login_QQ"];
    }
    return _imageArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (self.mj_w - RELATIVE_WIDTH(30) * 2 - RELATIVE_WIDTH(60) * 3) / 4;
        flowLayout.itemSize = CGSizeMake(itemWidth, RELATIVE_WIDTH(100));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(50), RELATIVE_WIDTH(30), RELATIVE_WIDTH(50), RELATIVE_WIDTH(30));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(60);
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT, WIN_WIDTH, RELATIVE_WIDTH(288)) collectionViewLayout:flowLayout];
        view.backgroundColor = [UIColor whiteColor];
        view.showsVerticalScrollIndicator = NO;
        view.scrollEnabled = NO;
        [view registerClass:[YYMineInvateShareViewCell class] forCellWithReuseIdentifier:cellID];
        [view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
        view.dataSource = self;
        view.delegate = self;
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (UIView *)backView {
    if (!_backView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT)];
        view.backgroundColor = mRGBAColor(0, 0, 0, .75);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        _backView = view;
    }
    return _backView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self backView];
        [self collectionView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)showShareStateMsg:(SSDKResponseState)state
{
    [self hide];
    NSString *stateMsg = nil;
    switch (state) {
        case SSDKResponseStateSuccess:
            stateMsg = @"分享成功";
            break;
            
        case SSDKResponseStateFail:
            stateMsg = @"分享失败";
            break;
            
        case SSDKResponseStateCancel:
            stateMsg = @"分享已取消";
            break;
            
        default:
            break;
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[self getCurrentViewController].view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = stateMsg;
    [HUD hide:YES afterDelay:1.5];
}

/** 获取当前View的控制器对象 */
- (UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


- (void)cancelButtonAction
{
    [self hide];
}

- (void)show
{
    [(mAppDelegate).window addSubview:self];
    self.backView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.collectionView.mj_y = WIN_HEIGHT - RELATIVE_WIDTH(288);
    }];
}

- (void)hide
{
    WS(weakSelf);
    [UIView animateWithDuration:0.5 animations:^{
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.backView.hidden = YES;
        strongSelf.collectionView.mj_y = WIN_HEIGHT;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
    });
}

- (void)tapAction
{
    [self hide];
}


#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYMineInvateShareViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYMineInvateShareViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setImage:[UIImage imageNamed:self.imageArray[indexPath.item]] title:self.titleArray[indexPath.item]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:_contentDic[@"text"]
                                     images:_contentDic[@"imageURL"]
                                        url:_contentDic[@"url"]
                                      title:_contentDic[@"title"]
                                       type:SSDKContentTypeAuto];
    
    YYShareType type = YYShareTypeNone;
    switch (indexPath.item) {
        case 0:
        {
            type = YYShareTypeWeChat;
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                [self showShareStateMsg:state];
            }];
            break;
        }
        case 1:
        {
            type = YYShareTypeWeChatTimeline;
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                [self showShareStateMsg:state];
            }];
            break;
        }
        case 2:
        {
            type = YYShareTypeWeibo;
            [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                [self showShareStateMsg:state];
            }];
            break;
        }
        case 3:
        {
            type = YYShareTypeQQ;
            [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                [self showShareStateMsg:state];
            }];
            break;
        }
    }
//    if (_shareBlock) {
//        _shareBlock(type);
//    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
        for (UIView *subview in view.subviews) {
            [subview removeFromSuperview];
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(10))];
        line.backgroundColor = YYSeparatorColor;
        [view addSubview:line];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:YYTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        button.frame = CGRectMake(0, RELATIVE_WIDTH(10), self.mj_w, RELATIVE_WIDTH(78));
        [button addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        return view;
    }
    return [UICollectionReusableView new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.mj_w, RELATIVE_WIDTH(88));
}

@end
