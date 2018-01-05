//
//  YYSearchViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchViewCell.h"
#import "YYSearchSelectionView.h"

@interface YYSearchViewCell ()
@property (nonatomic, weak) YYSearchSelectionView *searchSelectionView;

@end

@implementation YYSearchViewCell

- (YYSearchSelectionView *)searchSelectionView {
    if (!_searchSelectionView) {
        YYSearchSelectionView *view = [[YYSearchSelectionView alloc] initWithFrame:self.bounds];
        view.didSelectBlock = ^(YYSearchModel *searchModel) {
            if (_didSelectSearchResultBlock) {
                _didSelectSearchResultBlock(searchModel);
            }
        };
        [self.contentView addSubview:view];
        WS(ws);
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
        _searchSelectionView = view;
    }
    return _searchSelectionView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = YYGrayTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
    }
    return self;
}

- (void)setType:(YYSearchViewCellType)type
{
    _type = type;
    switch (type) {
        case YYSearchViewCellTypeDefault:
        {
            for (UIView *view in self.contentView.subviews) {
                [view removeFromSuperview];
            }
            break;
        }
        case YYSearchViewCellTypeHotSearch:
        {
            self.searchSelectionView.titleLabel.text = @"热搜";
            self.searchSelectionView.type = YYSearchSelectionViewTypeHot;
            break;
        }
        case YYSearchViewCellTypeHistorySearch:
        {
            self.searchSelectionView.titleLabel.text = @"历史搜索";
            self.searchSelectionView.type = YYSearchSelectionViewTypeHistory;
            self.searchSelectionView.deleteActionBlock = ^{
                if (_deleteHistoryBlock) {
                    _deleteHistoryBlock();
                }
            };
            break;
        }
        default:
            break;
    }
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.searchSelectionView.dataArray = dataArray;
}

@end
