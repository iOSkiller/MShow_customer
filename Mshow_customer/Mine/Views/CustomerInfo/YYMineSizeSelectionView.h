//
//  YYMineSizeSelectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMineSizeSelectionView : UIView
@property (nonatomic, copy) NSArray *selectionArray;
@property (nonatomic, copy) void (^selectSizeBlock)(NSString *size);

@end
