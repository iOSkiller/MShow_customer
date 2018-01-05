//
//  YYSelectDateViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectDateViewCell.h"

@interface YYSelectDateViewCell ()

@property (nonatomic, weak) UILabel *weekDayLabel;

@end

@implementation YYSelectDateViewCell


- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self dateLabel];
        [self infoLabel];
        
    }
    return self;
}

- (void)setType:(YYSelectDateViewCellType)type
{
    self.dateLabel.backgroundColor = [UIColor whiteColor];
    self.dateLabel.layer.cornerRadius = RELATIVE_WIDTH(26);
    self.dateLabel.layer.masksToBounds = YES;
    self.dateLabel.layer.borderWidth = RELATIVE_WIDTH(2);
    self.dateLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if (type == YYSelectDateViewCellTypeWeakDay) {
        self.dateLabel.layer.borderColor = YYSeparatorColor.CGColor;
        self.dateLabel.backgroundColor = YYSeparatorColor;
        [self.dateLabel layoutIfNeeded];
        self.infoLabel.hidden = YES;
        [self.infoLabel removeFromSuperview];
        WS(ws);
        [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(2));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(2));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(2));
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(2));
        }];
    } else {
        WS(ws);
        self.infoLabel.hidden = NO;
        self.infoLabel.text = @"";
        [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.contentView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(52));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(2));
        }];
        
        [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(52), RELATIVE_WIDTH(32)));
            make.centerX.equalTo(ws.contentView);
        }];
        
        
        switch (type) {
            case YYSelectDateViewCellTypeDay:
            {
                self.dateLabel.textColor = YYTextColor;
                self.infoLabel.hidden = YES;
                break;
            }
                
            case YYSelectDateViewCellTypeToday:
            {
                self.dateLabel.layer.borderColor = YYDisableColor.CGColor;
                [self.dateLabel layoutIfNeeded];
                self.infoLabel.text = @"今天";
                break;
            }
            case YYSelectDateViewCellTypeDateForRecieve:
            case YYSelectDateViewCellTypeDateForReturn:
            case YYSelectDateViewCellTypeDateInDuration:
            {
                self.dateLabel.layer.borderColor = YYGlobalColor.CGColor;
                [self.dateLabel layoutIfNeeded];
                self.dateLabel.backgroundColor = YYGlobalColor;
                self.dateLabel.textColor = [UIColor whiteColor];
                if (type == YYSelectDateViewCellTypeDateInDuration) {
                    self.infoLabel.text = @"";
                    self.infoLabel.hidden = YES;
                } else {
                    self.infoLabel.hidden = NO;
                    self.infoLabel.text = type == YYSelectDateViewCellTypeDateForRecieve ? @"收货" : @"归还";
                }
                
                break;
            }
            default:
                break;
        }
    }
    
}

@end
