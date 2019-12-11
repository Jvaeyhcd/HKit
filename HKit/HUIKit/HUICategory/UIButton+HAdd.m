//
//  UIButton+HAdd.m
//  DZNEmptyDataSet
//
//  Created by Salvador on 2019/12/11.
//

#import "UIButton+HAdd.h"

@implementation UIButton (HAdd)

+ (id)initButtonWithText:(NSString *)text
               textColor:(UIColor *)textColor
                 bgColor:(UIColor *)bgColor
                    font:(UIFont *)font {
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    button.titleLabel.font = font;
    
    return button;
}

@end
