//
//  YYCommentScoreViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentScoreViewCell.h"
#import "SYStarRatingView.h"

@interface YYCommentScoreViewCell () <StarRatingViewDelegate>
@property (nonatomic, weak) SYStarRatingView *starView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *scoreLabel;

@end

@implementation YYCommentScoreViewCell

- (SYStarRatingView *)starView {
    if (!_starView) {
        SYStarRatingView *view = [[SYStarRatingView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(280), RELATIVE_WIDTH(46)) numberOfStar:5];
        view.foregroundImageName = @"choose_btn_collect_pre";
        view.backgroundImageName = @"choose_btn_collect_n";
        view.delegate = self;
        view.backgroundColor = [UIColor whiteColor];
        [view setScore:1.0 withAnimation:NO];
        [self.contentView addSubview:view];
        _starView = view;
    }
    return _starView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"非常好";
        [self.contentView addSubview:label];
        _scoreLabel = label;
    }
    return _scoreLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self starView];
        [self nameLabel];
        [self scoreLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        WS(ws);
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0.0f);
            make.centerY.equalTo(ws.contentView);
        }];
        
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(RELATIVE_WIDTH(30));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(260), RELATIVE_WIDTH(34)));
            make.centerY.equalTo(ws.contentView);
        }];
        
        [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.starView.mas_right).offset(RELATIVE_WIDTH(24));
            make.width.greaterThanOrEqualTo(@0.0f);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.centerY.equalTo(ws.contentView);
        }];
        
        
    }
    return self;
}

- (void)setScoreType:(YYScoreType)scoreType
{
    _scoreType = scoreType;
    switch (scoreType) {
        case YYScoreTypeShop:
            self.nameLabel.text = @"店铺服务";
            break;
        case YYScoreTypeDelivery:
            self.nameLabel.text = @"描述相符";
            break;
        case YYScoreTypeDescription:
            self.nameLabel.text = @"物流服务";
            break;
        case YYScoreTypeTriedExperience:
            self.nameLabel.text = @"试穿体验";
            break;
    }
}

#pragma mark - StarRatingViewDelegate
- (void)starRatingView:(SYStarRatingView *)view score:(double)score
{
    if (score >= 0.9) {
        self.scoreLabel.text = @"非常好";
    } else if (score >= 0.7) {
        self.scoreLabel.text = @"好";
    } else if (score >= 0.6) {
        self.scoreLabel.text = @"一般";
    } else {
        self.scoreLabel.text = @"差";
    }
    
    if (_didMarkBlock) {
        _didMarkBlock(_scoreType, score);
    }
}

@end
