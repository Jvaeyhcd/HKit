//
//  UIButton+HAdd.h
//  DZNEmptyDataSet
//
//  Created by Salvador on 2019/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HAdd)

/// Create button with text, text color, background color and font
/// @param text text string
/// @param textColor text color
/// @param bgColor background color
/// @param font button's text font
+ (id)initButtonWithText:(NSString *)text
               textColor:(UIColor *)textColor
                 bgColor:(UIColor *)bgColor
                    font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
