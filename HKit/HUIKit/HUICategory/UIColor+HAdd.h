//
//  UIColor+HAdd.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/6/27.
//  Copyright © 2019 STS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HAdd)

/**
 快速构建rgb颜色
 @param r red
 @param g green
 @param b blue
 @param a alpha
 @return UIColor颜色
 */
+ (UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

/**
 生成随机颜色
 @return UIColor颜色
 */
+ (UIColor *)randomColor;

/**
 根据十六进制颜色值得到颜色
 @param hex 十六进制颜色值
 @return UIColor颜色
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

/**
 根据十六进制颜色值得到颜色（含透明度）
 @param hex 十进制颜色值
 @param alpha 透明度
 @return UIColor颜色
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;

/**
 根据十六进制颜色值字符串得到颜色
 @param hex 十六进制支付串
 @return UIColor颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hex;

/**
 根据十六进制颜色值字符串得到颜色（含透明度）
 @param hex 十六进制字符串
 @param alpha 透明度
 @return UIColor颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;

/**
 转纯色图片，一个像素大小
 @return UIImage像素图片
 */
- (UIImage *)toImage;

@end

NS_ASSUME_NONNULL_END
