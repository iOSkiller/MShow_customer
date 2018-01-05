//
//  YYMineInfoView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInfoView.h"
#import "YYMineInfoViewCell.h"
#import "YYMineSizeSelectionView.h"

#define IconRow 0
#define NickNameRow 1
#define LevelRow 2
#define GenderRow 3
#define PhoneRow 4
#define BirthDayRow 5
#define HeightRow 6

@interface YYMineInfoView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYMineSizeSelectionView *selectionView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation YYMineInfoView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        YYMineSizeSelectionView *footerView = [[YYMineSizeSelectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(214))];
        _selectionView = footerView;
        tableView.tableFooterView = footerView;
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setSeparatorColor:YYSeparatorColor];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        self.titleArray = @[@"头像", @"昵称", @"等级", @"性别", @"手机号", @"出生日期", @"身高"];
        self.selectionView.selectSizeBlock = ^(NSString *size) {
            
        };
    }
    return self;
}
- (void)setIcon:(UIImage *)image
{
    YYMineInfoViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:IconRow inSection:0]];
    cell.imgView.image = image;
}

- (void)setBirthDay:(NSString *)birthDay
{
    YYMineInfoViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:BirthDayRow inSection:0]];
    cell.detailTextLabel.text = birthDay;
}

- (void)setHeight:(NSString *)height
{
    YYMineInfoViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:HeightRow inSection:0]];
    cell.detailTextLabel.text = height;
}

- (void)setGender:(NSString *)gender
{
    YYMineInfoViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:GenderRow inSection:0]];
    cell.detailTextLabel.text = gender;
}

- (void)updateInfo:(NSString *)info type:(YYMineInfoType)type
{
    NSInteger index = 0;
    switch (type) {
        case YYMineInfoTypeNickname:
            index = NickNameRow;
            break;
        case YYMineInfoTypeHeight:
            index = HeightRow;
            break;
        case YYMineInfoTypePhone:
        {
            NSString *replaceStr = [info substringWithRange:NSMakeRange(3, 5)];
            info = [info replaceCharcter:replaceStr withCharcter:@"*****"];
            index = PhoneRow;
            break;
        }
        default:
            break;
    }
    YYMineInfoViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.detailTextLabel.text = info;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"CellID%ld%ld", (long)indexPath.row, (long)indexPath.section];
    YYMineInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineInfoViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            cell.type = YYMineInfoTypeIcon;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull YYMineInfoViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    NSString *text = nil;
    switch (indexPath.row) {
        case IconRow:
            break;
        case NickNameRow:
            text = @"妞妞吖";
            break;
        case LevelRow:
            text = @"初级麻豆";
            break;
        case GenderRow:
            text = @"女";
            break;
        case PhoneRow:
            text = @"183*****609";
            break;
        case BirthDayRow:
            text = @"请输入出身年月日";
            break;
        case HeightRow:
            text = @"请输入身高(cm)";
            break;
    }
    cell.detailTextLabel.text = text;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYMineInfoType type = YYMineInfoTypeIcon;
    switch (indexPath.row) {
        case IconRow:
            type = YYMineInfoTypeIcon;
            break;
        case NickNameRow:
            type = YYMineInfoTypeNickname;
            break;
        case LevelRow:
            type = YYMineInfoTypeLevel;
            break;
        case GenderRow:
            type = YYMineInfoTypeGender;
            break;
        case PhoneRow:
            type = YYMineInfoTypePhone;
            break;
        case BirthDayRow:
            type = YYMineInfoTypeBirthday;
            break;
        case HeightRow:
            type = YYMineInfoTypeHeight;
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gotoDetail:)]) {
        [_delegate gotoDetail:type];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(140);
    } else {
        return RELATIVE_WIDTH(100);
    }
}

@end
