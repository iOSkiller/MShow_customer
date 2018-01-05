//
//  YYMineGoodsCollectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineGoodsCollectionView.h"
#import "YYMineGoodsCollectionViewCell.h"
#import "YYHistoryFunctionView.h"

static NSString *const cellID = @"YYMineGoodsCollectionViewCellID";

@interface YYMineGoodsCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, YYHistoryFunctionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) YYHistoryFunctionView *functionView;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSMutableArray *originalArray;

@end

@implementation YYMineGoodsCollectionView

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
}

- (YYHistoryFunctionView *)functionView {
    if (!_functionView) {
        YYHistoryFunctionView *view = [[YYHistoryFunctionView alloc] initWithFrame:CGRectMake(0, self.mj_h - RELATIVE_WIDTH(100) - (kDevice_Is_iPhoneX ? RELATIVE_WIDTH(20) : 0), self.mj_w, RELATIVE_WIDTH(100))];
        view.delegate = self;
        [self addSubview:view];
        _functionView = view;
    }
    return _functionView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(34);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(8);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(24), RELATIVE_WIDTH(20), RELATIVE_WIDTH(24));
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(346), RELATIVE_WIDTH(520));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(80)) collectionViewLayout:flowLayout];
        
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[YYMineGoodsCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        view.showsVerticalScrollIndicator = NO;
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
        [self functionView];
        WS(ws);
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.originalArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    [self.collectionView reloadData];
    isEditing ? [self.functionView show] : [self.functionView hide];
    WS(ws);
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        isEditing ? make.bottom.equalTo(self.functionView.mas_top) : make.bottom.equalTo(ws);
    }];
    
}

- (void)delete:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath
{
    [self.originalArray removeObjectAtIndex:indexPath.item];
    [self.collectionView reloadData];
}

- (void)deleteSelectGoods
{
    [self.originalArray removeObjectsInArray:self.selectArray];
    [self.collectionView reloadData];
}

- (void)updateSelectArray:(YYGoodsModel *)goodsModel isSelected:(BOOL)isSelected index:(NSUInteger)index
{
    if (isSelected) {
        [self.selectArray addObject:goodsModel];
    } else {
        [self.selectArray removeObject:goodsModel];
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.originalArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYMineGoodsCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    WS(weakSelf);
    cell.deleteActionBlock = ^(YYGoodsModel *model) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeDeleteGoods:)]) {
            [_delegate executeDeleteGoods:model];
        }
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf delete:model indexPath:indexPath];
    };
    cell.selectActionBlock = ^(YYGoodsModel *goodsModel, BOOL isSelected) {
        StrongSelf(strongSelf)
        strongSelf = weakSelf;
        [strongSelf updateSelectArray:goodsModel isSelected:isSelected index:indexPath.row];
    };
    cell.isEditing = _isEditing;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYMineGoodsCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.goodsModel = self.originalArray[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:)]) {
        [_delegate executeShowGoodsDetail:self.dataArray[indexPath.item]];
    }
}

#pragma mark - YYHistoryFunctionViewDelegate
- (void)executeDelete
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeDeleteGoodsArray:)]) {
        [_delegate executeDeleteGoodsArray:self.selectArray];
    }
    [self deleteSelectGoods];
}

@end
