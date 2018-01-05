//
//  YYCommentDefectSelectionViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDefectModel;

@interface YYCommentDefectSelectionViewCell : UICollectionViewCell
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) YYDefectModel *defectModel;

@end
