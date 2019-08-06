//
//  NSString+HAdd.m
//  Flower
//
//  Created by 超讯研发部 on 2019/7/3.
//  Copyright © 2019 STS. All rights reserved.
//

#import "NSString+HAdd.h"

@implementation NSString (HAdd)

- (CGFloat)widthWithConstainedWidth:(CGFloat)width font:(UIFont *)font {
    CGSize constraintRect = CGSizeMake(width, CGFLOAT_MAX);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return boundingBox.size.width;
}

- (CGSize)sizeWithConstainedSize:(CGSize)size font:(UIFont *)font {
    CGRect boundingBox = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return boundingBox.size;
}

- (BOOL)isBlankString {
    if (self == nil) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        
        return YES;
    }
    return NO;
}

- (BOOL)haveEmptySpace {
    if (self == nil) {
        return NO;
    }
    NSRange range = [self rangeOfString:@" "];
    if (range.location == NSNotFound) {
        return NO;
    }
    return YES;
}

- (BOOL)paraStringLength:(NSInteger)maxLength minLength:(NSInteger)minLength {
    if (self == nil) {
        return NO;
    }
    
    if (self.length < minLength || self.length > maxLength) {
        return NO;
    }
    return YES;
}

- (BOOL)isIDCardNumber {
    if (self == nil || self.length == 0) {
        return NO;
    }
    
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *idCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [idCardPredicate evaluateWithObject:self];
}

- (BOOL)firstIsLetter {
    if (!self || [self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *letterPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regexLetter evaluateWithObject:self];
}

- (BOOL)isEmail {
    if (!self || [self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *email
}

@end
