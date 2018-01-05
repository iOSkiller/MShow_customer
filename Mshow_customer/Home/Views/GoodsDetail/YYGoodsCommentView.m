//
//  YYGoodsCommentView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/7.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsCommentView.h"
#import "YYCommentImageViewCell.h"
#import "YYCommentModel.h"

static NSString *const cellID = @"YYCommentImageViewCellID";
@interface YYGoodsCommentView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nickNameLabel;
@property (nonatomic, weak) UILabel *heightLabel;
@property (nonatomic, weak) UILabel *sizeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *upvoteButton;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYGoodsCommentView

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *view = [UIImageView new];
        view.layer.cornerRadius = RELATIVE_WIDTH(32);
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        view.image = [UIImage imageNamed:@"login_logo"];
        [self addSubview:view];
        _iconView = view;
    }
    return _iconView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"喵喵喵喵";
        [self addSubview:label];
        _nickNameLabel = label;
    }
    return _nickNameLabel;
}

- (UILabel *)heightLabel {
    if (!_heightLabel) {
        UILabel *label = [UILabel new];
        label.textColor = mRGBToColor(0x969696);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.text = @"身高:168CM";
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _heightLabel = label;
    }
    return _heightLabel;
}

- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        UILabel *label = [UILabel new];
        label.textColor = mRGBToColor(0x969696);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.text = @"尺寸:M";
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _sizeLabel = label;
    }
    return _sizeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.backgroundColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        [self addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIButton *)upvoteButton {
    if (!_upvoteButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_good_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"img_good_pre"] forState:UIControlStateSelected];
        [button setTitle:@"20" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(22)];
        [button addTarget:self action:@selector(upvoteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _upvoteButton = button;
    }
    return _upvoteButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (WIN_WIDTH - RELATIVE_WIDTH(60) - RELATIVE_WIDTH(20)) / 3;
        flowLayout.itemSize = CGSizeMake(width, RELATIVE_WIDTH(232));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(22), RELATIVE_WIDTH(30), RELATIVE_WIDTH(22), RELATIVE_WIDTH(30));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(10);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(280)) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        view.showsHorizontalScrollIndicator = NO;
        [view registerClass:[YYCommentImageViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self iconView];
        [self nickNameLabel];
        [self heightLabel];
        [self sizeLabel];
        [self contentLabel];
        [self upvoteButton];
        [self collectionView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)upvoteAction:(UIButton *)sender
{
    if (!_canUpvote) {
        return;
    }
    sender.selected = !sender.isSelected;
    if (_upvoteBlock) {
        _upvoteBlock(sender.isSelected);
    }
}

- (void)setCanUpvote:(BOOL)canUpvote
{
    _canUpvote = canUpvote;
    self.upvoteButton.selected = YES;

}

- (void)setContentHeight:(CGFloat)contentHeight
{
    _contentHeight = contentHeight;
    WS(ws);
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).offset(RELATIVE_WIDTH(30));
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
        make.width.height.mas_equalTo(RELATIVE_WIDTH(64));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
        make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(20));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(28)));
    }];
    
    [self.heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
        make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(20));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(140), RELATIVE_WIDTH(26)));
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.heightLabel.mas_right).offset(RELATIVE_WIDTH(14));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(140), RELATIVE_WIDTH(26)));
        make.top.equalTo(self.heightLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(RELATIVE_WIDTH(20));
        make.left.equalTo(ws).offset(RELATIVE_WIDTH(30));
        make.right.equalTo(ws).offset(-RELATIVE_WIDTH(120));
        make.height.mas_equalTo(contentHeight);
    }];
    
    [self.upvoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).offset(-RELATIVE_WIDTH(20));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(88), RELATIVE_WIDTH(44)));
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(76));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(280));
        make.top.equalTo(self.contentLabel.mas_bottom);
    }];
}

- (void)setCommentModel:(YYCommentModel *)commentModel
{
    _commentModel = commentModel;
    self.nickNameLabel.text = _commentModel.nickName;
    self.heightLabel.text = [NSString stringWithFormat:@"身高:%@CM", _commentModel.height];
    self.sizeLabel.text = [NSString stringWithFormat:@"尺寸:%@", _commentModel.size];
    [self.upvoteButton setTitle:_commentModel.upvoteCount forState:UIControlStateNormal];
    self.contentLabel.text = _commentModel.content;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.commentModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCommentImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYCommentImageViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.image = self.commentModel.images[indexPath.item];
}



@end
