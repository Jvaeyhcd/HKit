//
//  UILabel+HAdd.m
//  Flower
//
//  Created by 超讯研发部 on 2019/7/2.
//  Copyright © 2019 STS. All rights reserved.
//

#import "UILabel+HAdd.h"

@implementation UILabel (HAdd)

+ (UILabel *)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    
    return [UILabel initWithText:text font:font color:color alignment:NSTextAlignmentLeft];
}

+ (UILabel *)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = text;
    label.font = font;
    label.textColor = color;
    label.textAlignment = alignment;
    
    return label;
}

@end
