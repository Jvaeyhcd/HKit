//
//  UIImageView+HAdd.m
//  DZNEmptyDataSet
//
//  Created by Jvaeyhcd on 2019/8/29.
//

#import "UIImageView+HAdd.h"

@implementation UIImageView (HAdd)

- (void)bezierCornerRadius:(CGFloat)cornerRadius {
    
    UIImage *newImage = self.image;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    
    // 获取上下文，用Bezier曲线画圆，并裁剪
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius] addClip];
    // 将图片画进裁剪的图形中
    [newImage drawInRect:self.bounds];
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
}

@end
