//
//  YYMineWardrobeFunctionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineWardrobeFunctionView.h"

@interface YYMineWardrobeFunctionView ()
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation YYMineWardrobeFunctionView

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYGrayTextColor;
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"共1件   实付:￥304.00(包含运费￥4.00)";
        [self addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame functionArray:(NSArray *)functionArray haveDealInfo:(NSString *)dealInfo
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        if ([dealInfo isValid]) {
            self.priceLabel.text = dealInfo;
            [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
                make.top.equalTo(ws);
                make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
                make.height.mas_equalTo(RELATIVE_WIDTH(52));
            }];
        }
        
        
        UIView *lastView = nil;
        CGFloat width = (self.mj_w - RELATIVE_WIDTH(28) * 2 - RELATIVE_WIDTH(34) * 3) / 4;
        for (int i = 0; i < functionArray.count; i ++) {
            NSString *str = functionArray[i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:functionArray[i] forState:UIControlStateNormal];
            if ([str isEqualToString:@"取消订单"] ||
                [str isEqualToString:@"删除订单"] ||
                [str isEqualToString:@"查看物流"] ||
                [str isEqualToString:@"申诉"] ||
                [str isEqualToString:@"查看订单"]) {
                [button setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
                button.layer.borderColor = YYGrayTextColor.CGColor;
                button.layer.borderWidth = RELATIVE_WIDTH(1);
                button.backgroundColor = [UIColor whiteColor];
            } else {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor = YYGlobalColor;
            }
            button.layer.cornerRadius = CommonCornerRadius;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
            button.tag = 4000 + i;
            
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
                [dealInfo isValid] ? make.top.equalTo(self.priceLabel.mas_bottom) : make.centerY.equalTo(ws);
                make.height.mas_equalTo(RELATIVE_WIDTH(62));
                lastView ? make.right.equalTo(lastView.mas_left).offset(-RELATIVE_WIDTH(34)) : make.right.equalTo(ws.mas_right).offset(-RELATIVE_WIDTH(24));
            }];
            lastView = button;
        }
    }
    return self;
}

- (void)setDealInfo:(NSString *)dealInfo
{
    if ([dealInfo isValid]) {
        _dealInfo = dealInfo;
        self.priceLabel.text = dealInfo;
        self.priceLabel.hidden = NO;
    } else {
        self.priceLabel.hidden = YES;
    }
}

- (void)clickFunction:(UIButton *)sender
{
    YYMineFunctionType functionType = YYMineFunctionTypeBuy;
    switch (sender.tag) {
        case 4000:
        {
            switch (_statusType) {
                case YYDealStatusTypeTried:
                    functionType = YYMineFunctionTypeBuy;
                    break;
                case YYDealStatusTypeBought:
                    functionType = YYMineFunctionTypeChange;
                    break;
                case YYDealStatusTypeWaitForDelivery:
                    functionType = YYMineFunctionTypeRemindDeal;
                    break;
                case YYDealStatusTypeWaitForRecieve:
                    functionType = YYMineFunctionTypeConformReceipt;
                    break;
                case YYDealStatusTypeWaitForComment:
                    functionType = YYMineFunctionTypeComments;
                    break;
                case YYDealStatusTypeWaitForPay:
                    functionType = YYMineFunctionTypePayDeal;
                    break;
                case YYDealStatusTypeWaitForReturn:
                    functionType = YYMineFunctionTypeReturn;
                    break;
                case YYDealStatusTypeWaitForSubmit:
                    functionType = YYMineFunctionTypeSubmitDeal;
                    break;
                case YYDealStatusTypeWaitForTakeOrder:
                    functionType = YYMineFunctionTypeCancelDeal;
                    break;
                case YYDealStatusTypeReturnChange:
                    functionType = YYMineFunctionTypeShowDealDetail;
                    break;
                default:
                    break;
            }
            break;
        }
        case 4001:
        {
            switch (_statusType) {
                case YYDealStatusTypeBought:
                case YYDealStatusTypeTried:
                    functionType = YYMineFunctionTypeComments;
                    break;
                case YYDealStatusTypeWaitForPay:
                case YYDealStatusTypeWaitForDelivery:
                    functionType = YYMineFunctionTypeCancelDeal;
                    break;
                case YYDealStatusTypeWaitForReturn:
                    functionType = YYMineFunctionTypeReturnBySelf;
                    break;
                case YYDealStatusTypeWaitForComment:
                    functionType = YYMineFunctionTypeDeleteDeal;
                    break;
                case YYDealStatusTypeWaitForRecieve:
                    
                    break;
                case YYDealStatusTypeWaitForSubmit:
                case YYDealStatusTypeInAppeal:
                    functionType = YYMineFunctionTypeAppeal;
                    break;
                default:
                    break;
            }
            break;
        }
        case 4002:
        {
            switch (_statusType) {
                case YYDealStatusTypeBought:
                case YYDealStatusTypeTried:
                    functionType = YYMineFunctionTypeShow;
                    break;
                case YYDealStatusTypeWaitForReturn:
                    functionType = YYMineFunctionTypeBuy;
                    break;
                default:
                    break;
            }
            break;
        }
        case 4003:
        {
            switch (_statusType) {
                case YYDealStatusTypeTried:
                case YYDealStatusTypeBought:
                    functionType = YYMineFunctionTypeReturn;
                    break;
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    if (_buttonActionBlock) {
        _buttonActionBlock(functionType);
    }
}

@end
