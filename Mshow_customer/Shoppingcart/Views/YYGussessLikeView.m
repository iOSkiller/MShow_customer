//
//  YYGusessLikeView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGussessLikeView.h"
#import "YYSelectGenderViewCell.h"
#import "YYGoodsModel.h"

static NSString *const cellID = @"YYGusessLikeViewCellID";
@interface YYGussessLikeView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *leftLine;
@property (nonatomic, weak) UILabel *rightLine;

@end

@implementation YYGussessLikeView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"猜你喜欢";
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)leftLine {
    if (!_leftLine) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYTextColor;
        [self addSubview:label];
        _leftLine = label;
    }
    return _leftLine;
}

- (UILabel *)rightLine {
    if (!_rightLine) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYTextColor;
        [self addSubview:label];
        _rightLine = label;
    }
    return _rightLine;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(34);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(8);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(0), RELATIVE_WIDTH(24), RELATIVE_WIDTH(20), RELATIVE_WIDTH(24));
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(346), RELATIVE_WIDTH(520));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.scrollEnabled = NO;
        [view registerClass:[YYSelectGenderViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self collectionView];
        self.backgroundColor = [UIColor whiteColor];
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(180), RELATIVE_WIDTH(44)));
            make.centerX.equalTo(ws);
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
        }];
        
        [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleLabel.mas_left).offset(-RELATIVE_WIDTH(10));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(50), RELATIVE_WIDTH(2)));
            make.centerY.equalTo(self.titleLabel);
        }];
        
        [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(50), RELATIVE_WIDTH(2)));
            make.left.equalTo(self.titleLabel.mas_right).offset(RELATIVE_WIDTH(10));
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(88));
            make.left.right.bottom.equalTo(ws);
        }];
    }
    return self;
}

- (void)setLikeGoodsArray:(NSArray *)likeGoodsArray
{
    _likeGoodsArray = likeGoodsArray;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    if (_getContentHeight) {
        _getContentHeight(self.collectionView.contentSize.height);
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.likeGoodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYSelectGenderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.selectBlock = ^(YYGoodsModel *model, BOOL isSelected) {
        
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYSelectGenderViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.goodsModel = self.likeGoodsArray[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_showGoodsBlock) {
        _showGoodsBlock(self.likeGoodsArray[indexPath.item]);
    }
}


@end
