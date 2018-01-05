//
//  YYHomeCellCotentView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeCellCotentView.h"
#import "YYHomeContentViewCell.h"
#import "YYGoodsModel.h"

static NSString *const cellID = @"YYHomeCellCotentViewCellID";
@interface YYHomeCellCotentView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *rightLine;
@property (nonatomic, weak) UILabel *leftLine;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *moreButton;
@property (nonatomic, weak) UILabel *line;

@end

@implementation YYHomeCellCotentView
{
    BOOL _isScrolling;
}

- (UILabel *)line {
    if (!_line) {
        UILabel *line = [UILabel new];
        line.backgroundColor = mRGBColor(240, 240, 240);
        [self addSubview:line];
        _line = line;
    }
    return _line;
}

- (UILabel *)leftLine {
    if (!_leftLine) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBColor(102, 102, 102);
        [self addSubview:label];
        _leftLine = label;
    }
    return _leftLine;
}

- (UILabel *)rightLine {
    if (!_rightLine) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBColor(102, 102, 102);
        [self addSubview:label];
        _rightLine = label;
    }
    return _rightLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"更多" forState:UIControlStateNormal];
        [button setTitleColor:YYTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];
        _moreButton = button;
    }
    return _moreButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = 0.0;
        CGFloat itemHeight = 0.0;
        CGFloat height = 0.0;
        
        if (self.type == YYHomeCellTypeHot || self.type == YYHomeCellTypeNew || self.type == YYHomeCellTypeTried) {
            itemHeight = RELATIVE_WIDTH(300);
            itemWidth = itemHeight * 0.7;
//            height = homeFirstCellHeight * 0.86;
            height = RELATIVE_WIDTH(360);
        } else {
//            itemHeight = homeSecondCellHeight * 200 / homeSecondCellHeight;
            itemHeight = RELATIVE_WIDTH(200);
            itemWidth = itemHeight * 1.06;
//            height = homeSecondCellHeight * 0.795;
            height = RELATIVE_WIDTH(256);
        }
        
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(10);
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 24, 2, 24);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, height) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.showsHorizontalScrollIndicator = NO;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYHomeContentViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _collectionView = view;
        
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setType:(YYHomeCellType)type
{
    _type = type;
    switch (type) {
        case YYHomeCellTypeNew:
            self.titleLabel.text = @"新品区";
            break;
        case YYHomeCellTypeHot:
            self.titleLabel.text = @"爆品区";
            break;
        case YYHomeCellTypeShop:
            self.titleLabel.text = @"店铺推荐";
            break;
        case YYHomeCellTypeTried:
            self.titleLabel.text = @"完美体验";
            break;
        case YYHomeCellTypeLabel:
            break;
        case YYHomeCellTypeDefault:
            break;
    }
    [self collectionView];
    
    CGFloat labelWidth = [self.titleLabel.text getStringRect:self.titleLabel.font size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(34))].size.width + RELATIVE_WIDTH(10);
    
    WS(ws);
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(10));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(self.line.mas_bottom).offset(RELATIVE_WIDTH(30));
        make.size.mas_equalTo(CGSizeMake(labelWidth, RELATIVE_WIDTH(34)));
    }];
    
    [self.leftLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(50), RELATIVE_WIDTH(2)));
    }];
    
    [self.rightLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(50), RELATIVE_WIDTH(2)));
    }];
    
    [self.moreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(34)));
    }];
    
    CGSize collectionViewSize = self.collectionView.bounds.size;
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo(WIN_WIDTH);
        make.height.mas_equalTo(collectionViewSize.height);
        make.left.equalTo(ws);
    }];
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    [self.collectionView reloadData];
}

- (void)buttonAction
{
    if (_showMoreBlock) {
        _showMoreBlock(_type);
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYHomeContentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYHomeContentViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setGoodsModel:self.goodsArray[indexPath.item] type:_type];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectItemBlock) {
        _selectItemBlock([YYGoodsModel new], indexPath.item);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isScrolling = NO;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isScrolling = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ((scrollView.contentOffset.x >= self.collectionView.contentSize.width - self.collectionView.mj_w || self.collectionView.contentSize.width < self.collectionView.mj_w )) {
        if (!_isScrolling) {
            if (_showMoreBlock) {
                _showMoreBlock(_type);
            }
        }
        _isScrolling = YES;
    }
}

@end
