//
//  YYMineInvateHistoryViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateHistoryViewCell.h"
#import "YYInvateHistoryModel.h"

@interface YYMineInvateHistoryViewCell ()
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *infoLabel;

@end

@implementation YYMineInvateHistoryViewCell

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self.contentView addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setHistoryModel:(YYInvateHistoryModel *)historyModel
{
    WS(ws);
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
        make.height.mas_equalTo(RELATIVE_WIDTH(26));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
        make.height.mas_equalTo(RELATIVE_WIDTH(32));
    }];    _historyModel = historyModel;
    self.dateLabel.text = historyModel.date;
    self.infoLabel.text = [NSString stringWithFormat:@"通过您的邀请，%@成功注册", historyModel.name];
}

@end
