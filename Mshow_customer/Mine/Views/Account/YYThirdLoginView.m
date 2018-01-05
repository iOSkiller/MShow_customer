//
//  YYThirdLoginView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYThirdLoginView.h"
#import "YYThirdLoginHandle.h"

static NSString *cellID = @"YYThirdLoginViewCellID";
@interface YYThirdLoginView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *leftLine;
@property (nonatomic, weak) UIView *rightLine;

@end

@implementation YYThirdLoginView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"使用第三方账号登录";
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        UIView *view = [UIView new];
        view.backgroundColor = YYGrayTextColor;
        [self addSubview:view];
        _leftLine = view;
    }
    return _leftLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        UIView *view = [UIView new];
        view.backgroundColor = YYGrayTextColor;
        [self addSubview:view];
        _rightLine = view;
    }
    return _rightLine;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(100));
        flowLayout.sectionInset = UIEdgeInsetsMake(0, RELATIVE_WIDTH(114), 0, RELATIVE_WIDTH(114));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(40);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(100)) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(36));
            make.top.equalTo(ws);
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(self.titleLabel.mas_left).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
            make.centerY.equalTo(self.titleLabel);
        }];
        
        [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.left.equalTo(self.titleLabel.mas_right).offset(RELATIVE_WIDTH(26));
            make.centerY.equalTo(self.titleLabel);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(50));
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(100), RELATIVE_WIDTH(100))];
    [cell.contentView addSubview:imageView];
    switch (indexPath.item) {
        case 0:
            imageView.image = [UIImage imageNamed:@"login_QQ"];
            break;
        case 1:
            imageView.image = [UIImage imageNamed:@"login_WeChat"];
            break;
        case 2:
            imageView.image = [UIImage imageNamed:@"login_Sinaweibo"];
            break;
        case 3:
            imageView.image = [UIImage imageNamed:@"login_Paytreasure"];
            break;
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0:
        {
            [YYThirdLoginHandle loginByQQ:^(NSString *platName, NSString *userID, NSString *nickName, NSString *headURL) {
                if (_loginSuccessBlock) {
                    _loginSuccessBlock(platName, userID, nickName, headURL);
                }
            } failed:^(NSString *msg) {
                if (_loginFailedBlock) {
                    _loginFailedBlock(msg);
                }
            }];
        }
            break;
        case 1:
        {
            [YYThirdLoginHandle loginByWeixin:^(NSString *platName, NSString *userID, NSString *nickName, NSString *headURL) {
                if (_loginSuccessBlock) {
                    _loginSuccessBlock(platName, userID, nickName, headURL);
                }
            } failed:^(NSString *msg) {
                if (_loginFailedBlock) {
                    _loginFailedBlock(msg);
                }
            }];
        }
            break;
        case 2:
        {
            [YYThirdLoginHandle loginByWeibo:^(NSString *platName, NSString *userID, NSString *nickName, NSString *headURL) {
                if (_loginSuccessBlock) {
                    _loginSuccessBlock(platName, userID, nickName, headURL);
                }
            } failed:^(NSString *msg) {
                if (_loginFailedBlock) {
                    _loginFailedBlock(msg);
                }
            }];
        }
            break;
        case 3:
        {
            [YYThirdLoginHandle loginByAliPay:^(NSString *platName, NSString *userID, NSString *nickName, NSString *headURL) {
                if (_loginSuccessBlock) {
                    _loginSuccessBlock(platName, userID, nickName, headURL);
                }
            } failed:^(NSString *msg) {
                if (_loginFailedBlock) {
                    _loginFailedBlock(msg);
                }
            }];
        }
            break;
        default:
            break;
    }
}

@end
