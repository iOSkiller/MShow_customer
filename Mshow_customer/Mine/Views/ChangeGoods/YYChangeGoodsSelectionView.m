//
//  YYChangeGoodsSelectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChangeGoodsSelectionView.h"
#import "YYChangeReturnModel.h"

@interface YYChangeGoodsSelectionView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIView *functionView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIView *backView;

@end

@implementation YYChangeGoodsSelectionView

{
    NSUInteger _currentIndex;
    CGFloat _height;
}

- (UIView *)containerView {
    if (!_containerView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT, WIN_WIDTH, WIN_HEIGHT)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _containerView = view;
    }
    return _containerView;
}

- (UIView *)functionView {
    if (!_functionView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(100))];
        view.backgroundColor = YYSeparatorColor;
        [self.containerView addSubview:view];
        _functionView = view;
    }
    return _functionView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [self.functionView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.functionView).offset(RELATIVE_WIDTH(26));
            make.centerY.equalTo(self.functionView);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        _cancelButton = button;
    }
    return _cancelButton;
}

- (UIView *)backView {
    if (!_backView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        WS(ws);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.bottom.equalTo(self.containerView.mas_top);
        }];
        _backView = view;
    }
    return _backView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:YYGrayTextColor forState:UIControlStateDisabled];
        [button setTitleColor:YYGlobalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        button.enabled = NO;
        [self.functionView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.functionView).offset(-RELATIVE_WIDTH(26));
            make.centerY.equalTo(self.functionView);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        _sureButton = button;
    }
    return _sureButton;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(100), WIN_WIDTH, _height) style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.scrollEnabled = NO;
        view.delegate = self;
        view.dataSource = self;
        [self.containerView addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT);
        self.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        self.userInteractionEnabled = YES;
        [self backView];
        [self containerView];
        [self functionView];
        [self sureButton];
        [self cancelButton];
        [self tableView];
        if (kDevice_Is_iPhoneX) {
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, iPhone_MARGIN_BOTTOM)];
        }
    }
    return self;
}

- (void)setType:(YYChangeGoodsSelectionViewType)type
{
    _type = type;
}

- (void)setTypeArray:(NSArray *)typeArray
{
    _typeArray = typeArray;
    _height = RELATIVE_WIDTH(100) * typeArray.count;
    self.tableView.scrollEnabled = _height > WIN_HEIGHT / 2;
    _height = self.tableView.scrollEnabled ? WIN_HEIGHT / 2 : _height;
    self.tableView.mj_h = _height + iPhone_MARGIN_BOTTOM;
    [self.tableView reloadData];
    self.containerView.mj_h = _height + RELATIVE_WIDTH(100) + iPhone_MARGIN_BOTTOM;
}

- (void)setReasonArray:(NSArray *)reasonArray
{
    _reasonArray = reasonArray;
    _height = RELATIVE_WIDTH(100) * reasonArray.count;
    self.tableView.scrollEnabled = _height > WIN_HEIGHT / 2;
    _height = self.tableView.scrollEnabled ? WIN_HEIGHT / 2 : _height;
    self.tableView.mj_h = _height + iPhone_MARGIN_BOTTOM;
    [self.tableView reloadData];
    self.containerView.mj_h = _height + RELATIVE_WIDTH(100) + iPhone_MARGIN_BOTTOM;
}

- (void)hide
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.mj_y = WIN_HEIGHT;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)show
{
    [(mAppDelegate).window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.mj_y = WIN_HEIGHT - _height - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM;
    }];
}

- (void)cancelAction
{
    [self hide];
}

- (void)sureAction
{
    [self hide];
}

- (void)buttonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    NSUInteger index = sender.tag - 2020;
    
    if (sender.isSelected) {
        if (_currentIndex && _currentIndex != sender.tag) {
            UIButton *button = (UIButton *)[self viewWithTag:_currentIndex];
            button.selected = NO;
        }
        _currentIndex = sender.tag;
        if (_type == YYChangeGoodsSelectionViewTypeKind) {
            if (_didSelectChangeTypeBlock) {
                _didSelectChangeTypeBlock(self.typeArray[index]);
            }
        }
        
        if (_type == YYChangeGoodsSelectionViewTypeReason) {
            if (_didSelectChangeReasonBlock) {
                _didSelectChangeReasonBlock(self.reasonArray[index]);
            }
        }
        
        self.sureButton.enabled = YES;
    } else {
        if (_type == YYChangeGoodsSelectionViewTypeKind) {
            if (_didSelectChangeTypeBlock) {
                _didSelectChangeTypeBlock(nil);
            }
        }
        
        if (_type == YYChangeGoodsSelectionViewTypeReason) {
            if (_didSelectChangeReasonBlock) {
                _didSelectChangeReasonBlock(nil);
            }
        }
        
        self.sureButton.enabled = NO;
    }
    
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _type == YYChangeGoodsSelectionViewTypeReason ? self.reasonArray.count : self.typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYChangeGoodsSelectionViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        button.tag = indexPath.row + 2020;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.bounds = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
        cell.accessoryView = button;
        cell.textLabel.textColor = YYTextColor;
        YYChangeReturnModel *model = _type == YYChangeGoodsSelectionViewTypeKind ? self.typeArray[indexPath.row] : self.reasonArray[indexPath.row];
        cell.textLabel.text = _type == YYChangeGoodsSelectionViewTypeKind ? model.changeTypeContent : model.reasonTypeContent;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
    [self buttonAction:button];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(100);
}

@end
