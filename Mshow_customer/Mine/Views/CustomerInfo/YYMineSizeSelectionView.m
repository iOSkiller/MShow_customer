//
//  YYMineSizeSelectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineSizeSelectionView.h"
#import "YYMineSizeSelectionViewCell.h"
#import "YYMineSizeSelectionView.h"

static NSString *const cellID = @"YYMineSizeSelectionViewCellID";
@interface YYMineSizeSelectionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *subLabel;
@property (nonatomic, weak) UIView *line;

@end

@implementation YYMineSizeSelectionView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (WIN_WIDTH - RELATIVE_WIDTH(50) * 4 - RELATIVE_WIDTH(60)) / 5;
        flowLayout.itemSize = CGSizeMake(width, RELATIVE_WIDTH(40));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(30), RELATIVE_WIDTH(20), RELATIVE_WIDTH(30));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(30);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(50);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(150)) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.scrollEnabled = NO;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYMineSizeSelectionViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.text = @"穿衣尺码";
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.text = @"可多选";
        label.textColor = YYGrayTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _subLabel = label;
    }
    return _subLabel;
}

- (UIView *)line {
    if (!_line) {
        UIView *line = [UIView new];
        line.backgroundColor = YYSeparatorColor;
        [self addSubview:line];
        _line = line;
    }
    return _line;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self titleLabel];
        [self collectionView];
        self.selectionArray = @[@"XS", @"S", @"M", @"L", @"XL", @"XXL", @"XXXL"];
        self.backgroundColor = [UIColor whiteColor];
        
        WS(ws);
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(30));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(144), RELATIVE_WIDTH(38)));
        }];
        
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(RELATIVE_WIDTH(20));
            make.centerY.equalTo(self.titleLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(144), RELATIVE_WIDTH(38)));
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
            make.left.right.bottom.equalTo(ws);
        }];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYMineSizeSelectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYMineSizeSelectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.title = self.selectionArray[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYMineSizeSelectionViewCell *cell = (YYMineSizeSelectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;
    if (cell.isSelected) {
        if (_selectSizeBlock) {
            _selectSizeBlock(self.selectionArray[indexPath.item]);
        }
    }
}


@end
