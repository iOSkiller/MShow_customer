//
//  YYSearchSelectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchSelectionView.h"
#import "YYSearchModel.h"
#import "YYSearchSelectionViewCell.h"
#import "YYGoodsSpecificationFlowLayout.h"

static NSString *const cellID = @"YYSearchSelectionViewCellID";

@interface YYSearchSelectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIButton *deletButton;

@end

@implementation YYSearchSelectionView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        YYGoodsSpecificationFlowLayout *flowlayout = [[YYGoodsSpecificationFlowLayout alloc] init];
        flowlayout.maximumInteritemSpacing = RELATIVE_WIDTH(20);
        flowlayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowlayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(0), RELATIVE_WIDTH(26), RELATIVE_WIDTH(0), RELATIVE_WIDTH(26));
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(280)) collectionViewLayout:flowlayout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYSearchSelectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (UIButton *)deletButton {
    if (!_deletButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_deleting"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _deletButton = button;
    }
    return _deletButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self titleLabel];
        [self collectionView];
        WS(ws);
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(36));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
            make.left.right.bottom.equalTo(ws);
        }];
    }
    return self;
}

- (void)setType:(YYSearchSelectionViewType)type
{
    _type = type;
    if (type == YYSearchSelectionViewTypeHistory) {
        WS(ws);
        [self.deletButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.centerY.equalTo(self.titleLabel);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(26));
        }];
    }
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)deleteAction
{
    if (_deleteActionBlock) {
        _deleteActionBlock();
    }
}

#pragma mark - UICollectionViewDelegate/DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYSearchSelectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    YYSearchModel *model = self.dataArray[indexPath.item];
    cell.contentLabel.text = model.content;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectBlock) {
        _didSelectBlock(self.dataArray[indexPath.item]);
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    YYSearchModel *model = self.dataArray[indexPath.item];
    return CGSizeMake(model.content_width, model.content_height);
}


@end
