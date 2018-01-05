//
//  YYAdsModel.h
//  Service1.0
//
//  Created by YZ Y on 16/4/27.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYImageModel;

@interface YYAdsModel : NSObject
@property (nonatomic, copy) NSArray *result;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *msg;

- (void)transformImageURL:(YYAdsViewType)type;

@end
