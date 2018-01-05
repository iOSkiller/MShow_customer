//
//  YYReturnChangeDealViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYReturnChangeDealViewCell.h"
#import "YYChangeReturnFlowView.h"

@interface YYReturnChangeDealViewCell ()

@end

@implementation YYReturnChangeDealViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = YYTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        
        self.detailTextLabel.textColor = YYGrayTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
    }
    return self;
}

- (void)setType:(YYReturnChangeDealViewCellType)type
{
    _type = type;
    switch (_type) {
        case YYReturnChangeDealViewCellTypeSum:
            
            break;
        case YYReturnChangeDealViewCellTypeFlow:
        {
            YYChangeReturnFlowView *view = [[YYChangeReturnFlowView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(138))];
            [self.contentView addSubview:view];
        }
            break;
        case YYReturnChangeDealViewCellTypeReason:
            break;
        default:
            break;
    }
}


@end
