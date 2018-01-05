//
//  YYShowViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/31.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShowViewCell.h"
#import "YYShowDisplayViewCell.h"
#import "YYShowModel.h"

static NSString *const cellID = @"YYShowDisplayViewCellID";
@interface YYShowViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nickNameLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *reportButton;
@property (nonatomic, weak) UIButton *followButton;
@property (nonatomic, weak) UIButton *commentButton;
@property (nonatomic, weak) UIButton *upvoteButton;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UILabel *line;

@end

@implementation YYShowViewCell
{
    CGSize _itemSize;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = RELATIVE_WIDTH(42);
        view.layer.masksToBounds = YES;
        view.image = [UIImage imageNamed:@"login_logo"];
        [self.contentView addSubview:view];
        _iconView = view;
    }
    return _iconView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"喵喵喵喵";
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _nickNameLabel = label;
    }
    return _nickNameLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"5小时前";
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UIButton *)reportButton {
    if (!_reportButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_report"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _reportButton = button;
    }
    return _reportButton;
}

- (UIButton *)followButton {
    if (!_followButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"+关注" forState:UIControlStateNormal];
        [button setTitle:@"-取消关注" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.backgroundColor = YYGlobalColor;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _followButton = button;
    }
    return _followButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_message"] forState:UIControlStateNormal];
        [button setTitle:@"20" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [button addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _commentButton = button;
    }
    return _commentButton;
}

- (UIButton *)upvoteButton {
    if (!_upvoteButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_good_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"img_good_pre"] forState:UIControlStateSelected];
        [button setTitle:@"20" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [button addTarget:self action:@selector(upvoteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _upvoteButton = button;
    }
    return _upvoteButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_share"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _shareButton = button;
    }
    return _shareButton;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)line {
    if (!_line) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xf0f0f0);
        [self.contentView addSubview:label];
        _line = label;
    }
    return _line;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = _itemSize;
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(10);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(10);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(24), RELATIVE_WIDTH(20), RELATIVE_WIDTH(24));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(318)) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.scrollEnabled = NO;
        [view registerClass:[YYShowDisplayViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self iconView];
        [self nickNameLabel];
        [self dateLabel];
//        [self reportButton];
        [self followButton];
        [self contentLabel];
        [self commentButton];
        [self upvoteButton];
        [self shareButton];
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setItemSize:(CGSize)itemSize contentHeight:(CGFloat)contentHeight imageContainerHeight:(CGFloat)imageContainerHeight
{
    _itemSize = itemSize;
    [self collectionView];
    WS(ws);
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
        make.width.height.mas_equalTo(RELATIVE_WIDTH(84));
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
        
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(36));
        make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(14));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(30)));
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
        make.left.width.height.equalTo(self.nickNameLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(RELATIVE_WIDTH(20));
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
        make.height.mas_equalTo(contentHeight);
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom);
        make.height.mas_equalTo(imageContainerHeight - RELATIVE_WIDTH(208));
        make.left.right.equalTo(ws.contentView);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(40));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(130), RELATIVE_WIDTH(44)));
    }];
    
    //    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(40));
    //        make.right.equalTo(self.followButton.mas_left).offset(-RELATIVE_WIDTH(90));
    //        make.width.height.mas_equalTo(RELATIVE_WIDTH(50));
    //    }];
    
    
    CGFloat buttonWidth = (WIN_WIDTH - RELATIVE_WIDTH(80) * 2 - RELATIVE_WIDTH(80) * 2) / 3;
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, RELATIVE_WIDTH(50)));
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(80));
        make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
    }];
    
    [self.upvoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.mas_equalTo(self.commentButton);
        make.left.equalTo(self.commentButton.mas_right).offset(RELATIVE_WIDTH(80));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.mas_equalTo(self.commentButton);
        make.left.equalTo(self.upvoteButton.mas_right).offset(RELATIVE_WIDTH(80));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.contentView);
        make.height.mas_equalTo(RELATIVE_WIDTH(2));
        make.bottom.equalTo(self.commentButton.mas_top).offset(-RELATIVE_WIDTH(15));
    }];
}

- (void)setShowModel:(YYShowModel *)showModel
{
    _showModel = showModel;
    self.contentLabel.text = _showModel.content;
    [self.collectionView reloadData];
    
}

#pragma mark - button action
- (void)reportAction
{
    if (_reportBlock) {
        _reportBlock(_showModel);
    }
}

- (void)followAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    sender.backgroundColor = sender.selected ? YYDisableColor : YYGlobalColor;
    if (_followBlock) {
        _followBlock(_showModel);
    }
}

- (void)commentAction
{
    if (_commentBlock) {
        _commentBlock(_showModel);
    }
}

- (void)upvoteAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_upvoteBlock) {
        _upvoteBlock(_showModel);
    }
}

- (void)shareAction
{
    if (_shareBlock) {
        _shareBlock(_showModel);
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _showModel.imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYShowDisplayViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYShowDisplayViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.imageURL = _showModel.images[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_showImageBlock) {
        _showImageBlock(_showModel.imageURLs, indexPath.item);
    }
}






@end
