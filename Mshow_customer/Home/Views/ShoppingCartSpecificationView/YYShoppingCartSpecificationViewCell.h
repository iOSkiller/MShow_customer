//
//  YYShoppingCartSpecificationViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYShoppingCartSpecificationViewCellType) {
    YYShoppingCartSpecificationViewCellTypeSpecSelection,
    YYShoppingCartSpecificationViewCellTypeSizeSelection,
    YYShoppingCartSpecificationViewCellTypeCountSelection,
    
};

@interface YYShoppingCartSpecificationViewCell : UITableViewCell
@property (nonatomic, copy) void (^didSelectSpecBlock)(NSString *spec_id, NSString *spec);
@property (nonatomic, copy) void (^didSelectSizeBlock)(NSString *spec_id, NSString *size);
@property (nonatomic, copy) void (^didSelectCountBlock)(NSString *count);

- (void)setType:(YYShoppingCartSpecificationViewCellType)type selectionArray:(NSArray *)selectionArray;

@end
