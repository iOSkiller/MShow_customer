//
//  YYSelectDateViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYSelectDateViewCellType) {
    YYSelectDateViewCellTypeWeakDay,
    YYSelectDateViewCellTypeDay,
    YYSelectDateViewCellTypeToday,
    YYSelectDateViewCellTypeDateForRecieve,
    YYSelectDateViewCellTypeDateForReturn,
    YYSelectDateViewCellTypeDateInDuration,
};

@interface YYSelectDateViewCell : UICollectionViewCell
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, assign) YYSelectDateViewCellType type;

@end
