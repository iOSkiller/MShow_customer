//
//  YYImageFileModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYImageFileModel : NSObject

@property (nonatomic, copy) NSString *fileId;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileSize;
/**缩略图*/
@property (nonatomic, copy) NSString *fileThumbnail;
@property (nonatomic, copy) NSString *fileSuffix;
@property (nonatomic, copy) NSString *fileRemark;
@property (nonatomic, copy) NSString *fileTypeId;
/**图片地址*/
@property (nonatomic, copy) NSString *filePath;

@end
