//
//  YYGoodsSpecSelectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsSpecSelectionView.h"
#import "YYGoodsSpecificationCell.h"
#import "YYGoodsSpecificationFlowLayout.h"
#import "YYGoodsSpecificationModel.h"

static NSString *const cellID = @"YYGoodsSpecificationCellID";
@interface YYGoodsSpecSelectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray <YYGoodsSpecificationModel *> *originalArray;

@end


@implementation YYGoodsSpecSelectionView

{
    NSUInteger _currentIndex;
}

- (NSMutableArray *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        YYGoodsSpecificationFlowLayout *flowlayout = [[YYGoodsSpecificationFlowLayout alloc] init];
        flowlayout.maximumInteritemSpacing = RELATIVE_WIDTH(20);
        flowlayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowlayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(0), RELATIVE_WIDTH(24), RELATIVE_WIDTH(0), RELATIVE_WIDTH(24));
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(280)) collectionViewLayout:flowlayout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYGoodsSpecificationCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self titleLabel];
        [self collectionView];
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(2));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
            make.left.right.bottom.equalTo(ws);
        }];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.originalArray addObjectsFromArray:dataArray];
    [self.originalArray enumerateObjectsUsingBlock:^(YYGoodsSpecificationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.enable) {
            obj.isSelected = YES;
            _currentIndex = idx;
            *stop = YES;
        }
    }];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate/DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.originalArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYGoodsSpecificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    YYGoodsSpecificationModel *model = self.originalArray[indexPath.item];
    [cell setModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYGoodsSpecificationCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYGoodsSpecificationModel *model = self.originalArray[indexPath.item];
    if (model.enable && _currentIndex != indexPath.item) {
        model.isSelected = YES;
        if (_didSelectSpec) {
            _didSelectSpec(model.specid, model.name);
        }
        YYGoodsSpecificationModel *lastModel = self.originalArray[_currentIndex];
        lastModel.isSelected = NO;
    
        [self.originalArray replaceObjectAtIndex:_currentIndex withObject:lastModel];
        [self.originalArray replaceObjectAtIndex:indexPath.item withObject:model];
        [collectionView reloadData];
        _currentIndex = indexPath.item;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYGoodsSpecificationModel *model = self.originalArray[indexPath.item];
    return model.enable;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    YYGoodsSpecificationModel *model = self.originalArray[indexPath.item];
//    NSString *str = [NSString stringWithFormat:@"%@%@kg/%@%@", model.name, model.weight, model.unit, model.notes];
//    CGFloat width = [str getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(34)] size:CGSizeMake(MAXFLOAT, 44 - RELATIVE_WIDTH(20))].size.width + RELATIVE_WIDTH(20);
//    model.spec_width = width;
    if (model.spec_width > WIN_WIDTH - RELATIVE_WIDTH(40)) {
//        model.spec_height = [str getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(34)] size:CGSizeMake(WIN_WIDTH - RELATIVE_WIDTH(40), MAXFLOAT)].size.height + RELATIVE_WIDTH(60);
        return CGSizeMake(WIN_WIDTH - RELATIVE_WIDTH(40), model.spec_height);
    }
    
    return CGSizeMake(model.spec_width, RELATIVE_WIDTH(60));
}



@end
