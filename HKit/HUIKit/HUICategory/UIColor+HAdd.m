//
//  UIColor+HAdd.m
//  HKit
//
//  Created by Jvaeyhcd on 2019/6/27.
//  Copyright © 2019 STS. All rights reserved.
//

#import "UIColor+HAdd.h"

@implementation UIColor (HAdd)

+ (UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
}

+ (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256);
    CGFloat g = (CGFloat)arc4random_uniform(256);
    CGFloat b = (CGFloat)arc4random_uniform(256);
    return [UIColor colorWithRGB:r g:g b:b a:1.0];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    return [UIColor colorWithRGBHex:hex alpha:1.0];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRGB:r g:g b:b a:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha {
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [UIColor colorWithRGBHex:hexNum alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hex {
    return [UIColor colorWithHexString:hex alpha:1.0];
}

- (UIImage *)toImage {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
