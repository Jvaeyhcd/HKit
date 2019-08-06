//
//  UILabel+HAdd.h
//  Flower
//
//  Created by 超讯研发部 on 2019/7/2.
//  Copyright © 2019 STS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HAdd)

/**
 创建UILabel

 @param text 文字
 @param font 字体
 @param color 颜色
 @return UILabel
 */
+ (UILabel *)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;

/**
 创建UILabel

 @param text 文字
 @param font 字体
 @param color 颜色
 @param alignment 对其方式
 @return UILabel
 */
+ (UILabel *)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

@end

NS_ASSUME_NONNULL_END
