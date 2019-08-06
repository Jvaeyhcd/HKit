//
//  NSData+HAdd.h
//  Flower
//
//  Created by 超讯研发部 on 2019/7/12.
//  Copyright © 2019 STS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HAdd)

/**
 压缩图片到指定最大尺寸

 @param image 图片
 @param maxLength 最大尺寸，存储大小
 @return 压缩后的图片
 */
+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
