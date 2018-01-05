//
//  YYNavigationView.m
//  DDFood
//
//  Created by YZ Y on 16/6/3.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYNavigationView.h"
#import "YYSearchBar.h"
#import "YYBarButton.h"
#import "YYSegmentView.h"

@interface YYNavigationView () <YYSegmentViewDelegate>


//@property (nonatomic, weak) YYCommonButton *leftBtn;

@property (nonatomic, weak) UIButton *otherRightBtn;
@property (nonatomic, weak) UIButton *otherLeftBtn;
@property (nonatomic, weak) YYSearchBar *searchBar;
@property (nonatomic, weak) UILabel *bottomLine;
@property (nonatomic, weak) YYSegmentView *segmentView;

@end

@implementation YYNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageNamed:@"img_information"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        self.rightBtn = rightBtn;
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setTitle:@"南京" forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"img_arrow_down"] forState:UIControlStateNormal];
        [leftBtn setTitleColor:mRGBColor(51, 51, 51) forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.titleLabel.numberOfLines = 0;
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        
        leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -leftBtn.imageView.mj_w - RELATIVE_WIDTH(70), 0, leftBtn.imageView.mj_w);
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, leftBtn.titleLabel.mj_w, 0, -leftBtn.titleLabel.mj_w - RELATIVE_WIDTH(40));
        leftBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:leftBtn];
        self.leftBtn = leftBtn;
        
        YYSearchBar *searchBar = [[YYSearchBar alloc] init];
        searchBar.backgroundColor = [UIColor whiteColor];
        searchBar.type = YYSearchBarTypeLabel;
        searchBar.alpha = 0.8;
        [self addSubview:searchBar];
        self.searchBar = searchBar;
        self.searchBar.endEdite = ^(NSString *text) {
            [self getSearchText:text];
        };
        self.searchBar.showSearchViewBlock = ^(void) {
            [self showSearchListView];
        };
        UILabel *line = [UILabel new];
        line.backgroundColor = YYSeparatorColor;
        [self addSubview:line];
        self.bottomLine = line;
        self.hideLeftButton = NO;
        _haveSegment = NO;
        self.segmentView = nil;
    }
    return self;
}

- (void)setBlackStyle:(BOOL)blackStyle
{
    _blackStyle = blackStyle;
    self.leftBtn.selected = blackStyle;
    if (blackStyle) {
        [self.rightBtn setTitleColor:YYDiscriptionColor forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:YYDiscriptionColor forState:UIControlStateSelected];
        [self.rightBtn setImage:[UIImage imageNamed:@"xiaoxi_one_black"] forState:UIControlStateNormal];
    }
    
    self.searchBar.blackStyle = blackStyle;
    
}

- (void)setHideLeftButton:(BOOL)hideLeftButton
{
    _hideLeftButton = hideLeftButton;
    self.leftBtn.hidden = _hideLeftButton;
}

- (void)setSearchBarHaveCorner:(BOOL)searchBarHaveCorner
{
    _searchBarHaveCorner = searchBarHaveCorner;
    if (_searchBarHaveCorner) {
        self.searchBar.backgroundColor = [UIColor whiteColor];
//        self.searchBar.layer.cornerRadius = CommonCornerRadius;
        self.searchBar.layer.cornerRadius = RELATIVE_WIDTH(30);
        self.searchBar.layer.borderWidth = RELATIVE_WIDTH(1);
        self.searchBar.layer.borderColor = YYSeparatorColor.CGColor;
        self.searchBar.layer.masksToBounds = YES;
    }
}

- (void)setHaveBottomLine:(BOOL)haveBottomLine
{
    _haveBottomLine = haveBottomLine;
    if (_haveBottomLine) {
        self.bottomLine.hidden = !_haveBottomLine;
        self.searchBar.leftImage = YES;
    }
}

- (void)setHaveSegment:(BOOL)haveSegment
{
    _haveSegment = haveSegment;
    if (_haveSegment) {
        YYSegmentView *segmentView = [[YYSegmentView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, 44) selections:@[@"综合", @"销量", @"价格", @"评论"]];
        [self addSubview:segmentView];
        self.segmentView = segmentView;
        self.segmentView.delegate = self;
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        self.otherLeftBtn = leftBtn;
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageNamed:@"lined_two"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"lined"] forState:UIControlStateSelected];
        [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        self.otherRightBtn = rightBtn;
        
        self.rightBtn.hidden = YES;
        self.leftBtn.hidden  = YES;
        self.hideLeftButton = YES;
    }
}

- (void)setHide:(BOOL)hide
{
    [UIView animateWithDuration:3.0 animations:^{
        self.searchBar.hidden = hide;
        self.otherLeftBtn.hidden = hide;
        self.otherRightBtn.hidden = hide;
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(ws);
    
    if (!self.haveSegment) {
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            self.hideLeftButton ? make.left.equalTo(ws).offset(RELATIVE_WIDTH(14)) : make.left.equalTo(self.leftBtn.mas_right).offset(RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(60));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(40));
            make.right.equalTo(self.rightBtn.mas_left).offset(-RELATIVE_WIDTH(20));
            
        }];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.mas_right).offset(-RELATIVE_WIDTH(24));
            make.centerY.equalTo(self.searchBar);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(44), RELATIVE_WIDTH(44)));
        }];
    }
    
    if (self.haveBottomLine) {
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
            make.left.right.equalTo(ws);
            make.bottom.equalTo(ws.mas_bottom).offset(-RELATIVE_WIDTH(1));
        }];
        
    }
    
    if (self.segmentView) {
        [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(ws);
            make.top.equalTo(self.searchBar.mas_bottom).offset(RELATIVE_WIDTH(10));
        }];
        [self.otherRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.mas_top).offset(RELATIVE_WIDTH(64));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(40));
            make.right.equalTo(ws.mas_right).offset(- RELATIVE_WIDTH(20));
        }];
        [self.otherLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.mas_top).offset(RELATIVE_WIDTH(64));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(40));
            make.left.equalTo(ws.mas_left).offset(RELATIVE_WIDTH(10));
        }];
        [self.searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.mas_left).offset(RELATIVE_WIDTH(52));
            make.top.equalTo(ws.mas_top).offset(RELATIVE_WIDTH(60));
            make.height.mas_equalTo(RELATIVE_WIDTH(48));
            make.right.equalTo(ws.mas_right).offset(-RELATIVE_WIDTH(84));
        }];
    }
    
    if (!self.hideLeftButton) {
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.top.equalTo(ws.mas_top).offset(RELATIVE_WIDTH(50));
            make.left.equalTo(ws.mas_left).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(self.searchBar);
            self.segmentView ? make.width.mas_equalTo(RELATIVE_WIDTH(22)) : make.width.mas_equalTo(RELATIVE_WIDTH(120));
//            self.segmentView ? make.height.mas_equalTo(RELATIVE_WIDTH(42)): make.bottom.equalTo(ws.mas_bottom).offset(-RELATIVE_WIDTH(16));
            make.height.mas_equalTo(RELATIVE_WIDTH(88));
        }];
    }
}

- (void)setHideKeyboard:(BOOL)hideKeyboard
{
    if (hideKeyboard) {
        [self.searchBar.textField resignFirstResponder];
    }
}

- (void)setHideLine:(BOOL)hideLine
{
    self.searchBar.hideLine = hideLine;
}

- (void)refresh
{
    NSRange range = [(mAppDelegate).city rangeOfString:@"市"];
    [self.leftBtn setTitle:[(mAppDelegate).city substringToIndex:range.location] forState:UIControlStateNormal];
    //CGFloat normalWidth = [@"南京" getStringRect:self.leftBtn.titleLabel.font size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(28))].size.width;
   // [self.leftBtn setTitle:@"乌鲁木齐" forState:UIControlStateNormal];
//    if ([self.leftBtn.currentTitle getStringRect:self.leftBtn.titleLabel.font size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(28))].size.width > normalWidth) {
//        self.leftBtn.titleEdgeInsets = UIEdgeInsetsZero;
//        self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -RELATIVE_WIDTH(12), 0, 0);
//    } else {
//        self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, RELATIVE_WIDTH(4), 0, 0);
//        self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -RELATIVE_WIDTH(12), 0, 0);
//    }
}

#pragma mark - 点击事件

- (void)clickLeftBtn
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickLeftButton)]) {
        [_delegate clickLeftButton];
    }
}

- (void)clickRightBtn:(UIButton *)button
{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(clickRightButton:)]) {
        [_delegate clickRightButton:button];
    }
}

- (void)getSearchText:(NSString *)text
{
    if (_delegate && [_delegate respondsToSelector:@selector(searchText:)]) {
        [_delegate searchText:text];
    }
}

- (void)showSearchListView
{
    [self.searchBar.textField resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(showSearchView)]) {
        [_delegate showSearchView];
    }
}

#pragma mark - YYSegmentViewDelegate
- (void)clickSelectionID:(NSString *)selectionID ascending:(BOOL)ascending
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickSegement:ascending:)]) {
        [_delegate clickSegement:selectionID ascending:ascending];
    }
}

@end
