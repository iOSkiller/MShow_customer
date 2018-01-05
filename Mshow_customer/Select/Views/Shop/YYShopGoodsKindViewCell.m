//
//  YYShopGoodsKindViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopGoodsKindViewCell.h"
#import "YYShopGoddsKindSelectionViewCell.h"
#import "YYShopGoodsKindModel.h"

static NSString *const cellID = @"YYShopGoddsKindSelectionViewCellID";
@interface YYShopGoodsKindViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *allButton;

@end

@implementation YYShopGoodsKindViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"查看全部" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(allAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _allButton = button;
    }
    return _allButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(10);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(20);
        CGFloat width = (WIN_WIDTH - RELATIVE_WIDTH(20)) / 2;
        flowLayout.itemSize = CGSizeMake(width, RELATIVE_WIDTH(100));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(10), 0, RELATIVE_WIDTH(10), 0);
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(230)) collectionViewLayout:flowLayout];
        view.dataSource = self;
        view.delegate = self;
        view.scrollEnabled = NO;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYShopGoddsKindSelectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self.contentView addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self titleLabel];
        [self allButton];
        [self collectionView];
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(34));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@0);
            make.centerY.equalTo(self.titleLabel);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(24));
            make.bottom.left.right.equalTo(ws.contentView);
        }];
        
    }
    return self;
}

- (void)allAction
{
    if (_showAllKindsBlock) {
        _showAllKindsBlock(_kindModel);
    }
}

- (void)setKindModel:(YYShopGoodsKindModel *)kindModel
{
    _kindModel = kindModel;
    self.titleLabel.text = kindModel.type_content;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.kindModel.kindArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYShopGoddsKindSelectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    YYShopGoodsKindModel *model = self.kindModel.kindArray[indexPath.item];
    cell.contentLabel.text = model.kind_content;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectKindBlock) {
        _didSelectKindBlock(self.kindModel.kindArray[indexPath.item]);
    }
}
@end
