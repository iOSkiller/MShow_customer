//
//  YYSelectTypeSelectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectTypeSelectionView.h"
#import "YYSelectTypeSelectionViewCell.h"
#import "YYTypeSelectionModel.h"

static NSString *const cellID = @"YYSelectTypeSelectionViewCellID";
@interface YYSelectTypeSelectionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UIButton *resetButton;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation YYSelectTypeSelectionView

{
    YYTypeSelectionModel *_selectedModel;
    CGRect _frame;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(88);
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        CGFloat itemWidth = (self.mj_w - RELATIVE_WIDTH(88) * 2 - RELATIVE_WIDTH(88)) / 2;
        flowLayout.itemSize = CGSizeMake(itemWidth, RELATIVE_WIDTH(36));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(88), RELATIVE_WIDTH(20), RELATIVE_WIDTH(88));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[YYSelectTypeSelectionViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = mRGBToColor(0xf3615f);
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _sureButton = button;
    }
    return _sureButton;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"重置" forState:UIControlStateNormal];
        [button setTitleColor:YYTextColor forState:UIControlStateNormal];
        button.backgroundColor = mRGBToColor(0xf0f0f0);
        [button addTarget:self action:@selector(restBlock) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _resetButton = button;
    }
    return _resetButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self collectionView];
        [self sureButton];
        [self resetButton];
        _frame = frame;
        
        WS(ws);
        CGFloat width = self.mj_w / 2;
        [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(ws);
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(80)));
        }];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(ws);
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(80)));
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.bottom.equalTo(self.sureButton.mas_top);
        }];
    }
    return self;
}

- (void)setSelectionArray:(NSArray *)selectionArray
{
    _selectionArray = selectionArray;
    [self.collectionView reloadData];
}

- (void)sureAction
{
    [self hide];
    if (_sureBlock) {
        _sureBlock(_selectedModel);
    }
}

- (void)restBlock
{
    _selectedModel = nil;
    [self.collectionView reloadData];
    if (_resetBlock) {
        _resetBlock();
    }
}

- (void)show
{
    self.mj_y = -self.mj_h;
    self.hidden = NO;
    [UIView animateWithDuration:.5 animations:^{
        self.frame = _frame;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:.5 animations:^{
        self.mj_y = -self.mj_h;
    }];
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
    YYSelectTypeSelectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYSelectTypeSelectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = self.selectionArray[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedModel = self.selectionArray[indexPath.item];
//    model.isSelected = !model.isSelected;
//    YYSelectTypeSelectionViewCell *cell = (YYSelectTypeSelectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.model = model;
//    if (model.isSelected) {
//        [self.selectedArray addObject:model];
//    } else {
//        for (YYTypeSelectionModel *selectedModel in self.selectedArray) {
//            if ([selectedModel.selectionID isEqualToString:model.selectionID]) {
//                [self.selectedArray removeObject:selectedModel];
//                break;
//            }
//        }
//    }
//    if (_selectBlock) {
//        _selectBlock(self.selectedArray);
//    }
//    if (_selectBlock) {
//        _selectBlock(model);
//    }
}



@end
