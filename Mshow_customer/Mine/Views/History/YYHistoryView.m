//
//  YYHistoryView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryView.h"
#import "YYHistoryViewCell.h"
#import "YYHistoryHeaderView.h"
#import "YYHistoryModel.h"
#import "YYGoodsModel.h"


static NSString *const cellID = @"YYHistoryViewCellID";
static NSString *const headerID = @"YYHistoryViewHeaderID";
@interface YYHistoryView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <YYHistoryModel *> *selectArray;
@property (nonatomic, strong) NSMutableArray <YYHistoryModel *> *originalArray;

@end

@implementation YYHistoryView

- (NSMutableArray <YYHistoryModel *> *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray <YYHistoryModel *> *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
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
        [view registerClass:[YYHistoryViewCell class] forCellWithReuseIdentifier:cellID];
        [view registerClass:[YYHistoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
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
    //还原数据
    for (YYHistoryModel *model in self.dataArray) {
        [model.selectArray removeAllObjects];
        for (YYGoodsModel *goodsModel in model.goodsArray) {
            goodsModel.isSelected = NO;
        }
    }
    [self.collectionView reloadData];
}

- (void)updateSelectArray:(YYGoodsModel *)goods isSelected:(BOOL)isSelected indexPath:(NSIndexPath *)indexPath
{
    YYHistoryModel *historyModel = self.originalArray[indexPath.section];
    for (YYHistoryModel *originalHistoryModel in self.dataArray) {
        for (YYGoodsModel *originalModel in originalHistoryModel.goodsArray) {
            //更新原数据
            if ([originalModel.goodsID isEqualToString:goods.goodsID]) {
                originalModel.isSelected = isSelected;
                break;
            }
        }
    }
    if (isSelected) {
        [historyModel.selectArray addObject:goods];
    } else {
        [historyModel.selectArray removeObject:goods];
        if (historyModel.goodsArray.count == 0) {
            [self.selectArray removeObject:historyModel];
        }
    }
    
    historyModel.isSelected = historyModel.selectArray.count == historyModel.goodsArray.count;
    for (YYHistoryModel *originalModel in self.dataArray) {
        if ([originalModel.date isEqualToString:historyModel.date]) {
            originalModel.isSelected = historyModel.isSelected;
            break;
        }
    }
    
    __block BOOL isHaven = NO;
    //枚举器遍历数组
    [self.selectArray enumerateObjectsUsingBlock:^(YYHistoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //更新数据
        if ([obj.historyID isEqualToString:historyModel.historyID]) {
            [self.selectArray replaceObjectAtIndex:idx withObject:historyModel];
            isHaven = YES;
            *stop = YES;
        }
    }];
    
    if (!isHaven) {
        [self.selectArray addObject:historyModel];
    }
    [self.collectionView reloadData];
}

- (void)deleteSelectedGoods
{
    for (YYHistoryModel *selectModel in self.selectArray) {
        if (selectModel.selectArray.count == selectModel.goodsArray.count) {
            [self.originalArray removeObject:selectModel];
        } else {
            //枚举器遍历数组
            [self.originalArray enumerateObjectsUsingBlock:^(YYHistoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //更新数据
                if ([obj.historyID isEqualToString:selectModel.historyID]) {
                    NSMutableArray *array = [NSMutableArray arrayWithArray:selectModel.goodsArray];
                    [array removeObjectsInArray:selectModel.selectArray];
                    [selectModel.selectArray removeAllObjects];
                    selectModel.goodsArray = array;
                    [self.originalArray replaceObjectAtIndex:idx withObject:selectModel];
                    *stop = YES;
                }
            }];
        }
    }
    
    [self.collectionView reloadData];
    [self.selectArray removeAllObjects];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.originalArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    YYHistoryModel *historyModel = self.originalArray[section];
    return historyModel.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYHistoryViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.likeActionBlock = ^(YYGoodsModel *model, BOOL isSelected) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeLikeGoods:isLike:)]) {
            [_delegate executeLikeGoods:model isLike:isSelected];
        }
    };
    WS(weakSelf);
    cell.selectActionBlock = ^(YYGoodsModel *goodsModel, BOOL isSelected) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf updateSelectArray:goodsModel isSelected:isSelected indexPath:indexPath];
    };
    cell.isEditing = _isEditing;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        YYHistoryHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        headerView.backgroundColor = mRGBToColor(0xf0f0f0);
        YYHistoryModel *model = self.originalArray[indexPath.section];
        headerView.date = model.date;
        headerView.isEditing = _isEditing;
        headerView.isSelected = model.isSelected;
        WS(weakSelf);
        headerView.selectBlock = ^(BOOL isSelected) {
            model.isSelected = isSelected;
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            for (YYGoodsModel *goodsModel in model.goodsArray) {
                goodsModel.isSelected = isSelected;
            }
            if (isSelected) {
                [model.selectArray addObjectsFromArray:model.goodsArray];
                [strongSelf.selectArray addObject:model];
            } else {
                [model.selectArray removeAllObjects];
                [strongSelf.selectArray removeObject:model];
            }
            [strongSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        };
        return headerView;
    }
    return [UICollectionReusableView new];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYHistoryViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYHistoryModel *historyModel = self.originalArray[indexPath.section];
    cell.goodsModel = historyModel.goodsArray[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:)]) {
        YYHistoryModel *model = self.originalArray[indexPath.section];
        [_delegate executeShowGoodsDetail:model.goodsArray[indexPath.item]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section

{
    return CGSizeMake(self.mj_w, RELATIVE_WIDTH(60));
}



@end
