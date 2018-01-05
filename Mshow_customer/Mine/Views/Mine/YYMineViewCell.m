//
//  YYMineViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineViewCell.h"
#import "YYMineFunctionView.h"

@interface YYMineViewCell ()

@end

@implementation YYMineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = mRGBToColor(0x353535);
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        self.detailTextLabel.textColor = mRGBToColor(0xb9b9b9);
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    YYMineFunctionView *view = [[YYMineFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(150))];
    [self.contentView addSubview:view];
    [view setTitleArray:titleArray imageArray:imageArray countArray:nil];
    view.tapActionBlock = ^(NSUInteger index) {
        if (_fuctionBlock) {
            _fuctionBlock(index);
        }
    };
}

@end
