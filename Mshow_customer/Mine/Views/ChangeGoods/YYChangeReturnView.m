//
//  YYChangeReturnView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChangeReturnView.h"
#import "YYCommentSelectImageView.h"
#import "YYTextView.h"
#import "YYChangeGoodsSelectionView.h"
#import "YYChangeReturnModel.h"
#import "YYBottomSelectView.h"

@interface YYChangeReturnView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYCommentSelectImageView *selectImageView;
@property (nonatomic, weak) YYTextView *textView;

@end

@implementation YYChangeReturnView

{
    YYChangeReturnModel *_typeReasonmodel;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(860))];
        footerView.backgroundColor = [UIColor whiteColor];
        UIView *line1 = [UIView new];
        line1.backgroundColor = YYSeparatorColor;
        [footerView addSubview:line1];
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = YYSeparatorColor;
        [footerView addSubview:line2];
        
        UIView *line3 = [UIView new];
        line3.backgroundColor = YYSeparatorColor;
        [footerView addSubview:line3];
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYGrayTextColor;
        label.text = @"退换说明";
        label.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:label];
        
        YYTextView *textView = [[YYTextView alloc] init];
        [textView setPlaceHolder:@"请您填写退换说明" placeHolderTextColor:YYPlaceHolderColor];
        textView.maxTextCount = 150;
        textView.numLabelText = @"最多输入150字";
        textView.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textView.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:textView];
        _textView = textView;
        
        YYCommentSelectImageView *imageSelectView = [[YYCommentSelectImageView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(240))];
        imageSelectView.maxImagesCount = 3;
        [footerView addSubview:imageSelectView];
        _selectImageView = imageSelectView;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"提交申请" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.backgroundColor = YYDisableColor;
        button.enabled = NO;
        [button addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(footerView);
            make.height.mas_offset(RELATIVE_WIDTH(1));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1.mas_bottom).offset(RELATIVE_WIDTH(26));
            make.left.equalTo(footerView).offset(RELATIVE_WIDTH(28));
            make.right.equalTo(footerView).offset(-RELATIVE_WIDTH(28));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
        }];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.equalTo(footerView).offset(RELATIVE_WIDTH(22));
            make.right.equalTo(footerView).offset(-RELATIVE_WIDTH(22));
            make.height.mas_equalTo(RELATIVE_WIDTH(260));
        }];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(textView.mas_bottom);
            make.left.right.equalTo(footerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        [imageSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.mas_bottom);
            make.left.equalTo(footerView);
            make.right.equalTo(footerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(240));
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageSelectView.mas_bottom);
            make.left.equalTo(footerView).offset(RELATIVE_WIDTH(30));
            make.right.equalTo(footerView).offset(-RELATIVE_WIDTH(30));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        
        self.textView.textDidChangeBlock = ^(CGSize textSize, NSString *text) {
            button.enabled = [text isValid];
            button.backgroundColor = [text isValid] ? YYGlobalColor : YYDisableColor;
        };
        
        self.selectImageView.pickImageBlock = ^(NSInteger imagesCount) {
            if (_delegate && [_delegate respondsToSelector:@selector(executePickImage:)]) {
                [_delegate executePickImage:imagesCount];
            }
        };
        
        self.selectImageView.showImageBlock = ^(UIImage *image, NSUInteger index) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowImage:index:)]) {
                [_delegate executeShowImage:image index:index];
            }
        };
        
        self.selectImageView.didChangeImage = ^(NSArray *imageArray) {
            self.imageArray = imageArray;
            if (_delegate && [_delegate respondsToSelector:@selector(executeChangeImage:)]) {
                [_delegate executeChangeImage:imageArray];
            }
        };
        
        self.tableView.tableFooterView = footerView;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    self.selectImageView.imageArray = imageArray;
}

- (void)submitAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeSubmit)]) {
        [_delegate executeSubmit];
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYChangeReturnViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = YYGrayTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        cell.detailTextLabel.textColor = YYTextColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_down"]];
        arrowView.bounds = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"退款类型";
                cell.accessoryView = arrowView;
                break;
            case 1:
                cell.textLabel.text = @"收货状态";
                arrowView.image = nil;
                cell.accessoryView = arrowView;
                cell.detailTextLabel.text = @"已收到货";
                break;
            case 2:
                cell.textLabel.text = @"退换原因";
                cell.accessoryView = arrowView;
                break;
            case 3:
                cell.textLabel.text = @"退款金额";
                arrowView.image = nil;
                cell.accessoryView = arrowView;
                cell.detailTextLabel.text = @"￥300.00";
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = [_typeReasonmodel.changeTypeContent isValid] ? _typeReasonmodel.changeTypeContent : @"请选择退款类型";
            break;
        case 2:
            cell.detailTextLabel.text = [_typeReasonmodel.reasonTypeContent isValid] ? _typeReasonmodel.reasonTypeContent : @"请选择退换原因";
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    if (indexPath.row == 0) {
        YYChangeGoodsSelectionView *view = [[YYChangeGoodsSelectionView alloc] init];
        view.type = YYChangeGoodsSelectionViewTypeKind;
        view.typeArray = [YYChangeReturnModel testTypeArray];
        
        view.didSelectChangeTypeBlock = ^(YYChangeReturnModel *typeModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            _typeReasonmodel = typeModel;
            [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        [view show];
    }
    
    if (indexPath.row == 2) {
        YYChangeGoodsSelectionView *view = [[YYChangeGoodsSelectionView alloc] init];
        view.type = YYChangeGoodsSelectionViewTypeReason;
        view.reasonArray = [YYChangeReturnModel testReasonArray];
        view.didSelectChangeReasonBlock = ^(YYChangeReturnModel *reasonModel) {
            _typeReasonmodel = reasonModel;
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        [view show];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(82);
}

@end
