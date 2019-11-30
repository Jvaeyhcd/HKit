//
//  UIView+HAdd.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/6/27.
//  Copyright © 2019 STS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HAdd)

#pragma mark - Frame

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

/**
 给UIView组件添加阴影
 @param offset 偏移
 @param radius 半径
 @param color 颜色
 @param opacity 透明度
 */
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;

/**
 给UI直接添加阴影
 @param offset 偏移
 @param radius 半径
 @param color 颜色
 @param opacity 透明度
 */
- (void)addShadowWithOffset:(CGSize)offset
                     radius:(CGFloat)radius
                      color:(UIColor *)color
                    opacity:(CGFloat)opacity;

/**
 设置bottom border的半径
 @param radius 半径
 */
- (void)setCornerOnBottom:(CGFloat)radius;

/**
 设置top border半径
 @param radius 半径
 */
- (void)setCornerOnTop:(CGFloat)radius;

/**
 设置left border半径
 @param radius 半径
 */
- (void)setCornerOnLeft:(CGFloat)radius;


/**
 设置right border半径
 @param radius 半径
 */
- (void)setCornerOnRight:(CGFloat)radius;


/**
 将页面组件转换为图片
 @return UIView生成的图片
 */
- (UIImage *)convertViewToImage;


/**
 给UIView添加点击事件
 @param target 目标
 @param action 事件方法
 */
- (void)addTarget:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
