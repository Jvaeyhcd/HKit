//
//  NSString+HAdd.m
//  HKit
//
//  Created by Jvaeyhcd on 2019/7/3.
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

+ (BOOL)isBlankString:(NSString *)str {
    if (str == nil) {
        return YES;
    }
    if (str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        
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
    return [letterPredicate evaluateWithObject:self];
}

- (BOOL)isEmail {
    if (!self || [self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailPredicate evaluateWithObject:self];
}

- (BOOL)isMobileNumber {
    if (!self || [self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    /**
     * 手机号码
     * 移动：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、172、178、182、183、184、187、188、198
     * 联通：130、131、132、145、155、156、166、171、175、176、185、186
     * 电信：133、149、153、173、177、180、181、189、191、199、193
     * 虚拟运营商：170、167、162、165
     *
     */
    NSString *regex = @"^1(3[0-9]|4[0-9]|5[0-9]|6[567]|7[0-8]|8[0-9]|9[189])\\d{8}$";
    
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [mobilePredicate evaluateWithObject:self];
}

- (BOOL)isHttpRequestUrl {
    
    if (!self || [self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [urlPredicate evaluateWithObject:self];
}

- (BOOL)isPassportNumber {
    
    if (!self || [self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    /** 第一位是字母，后面都是数字
     
     P:P开头的是因公普通护照
     D:外交护照是D开头
     E:有电子芯片的普通护照为“E”字开头，
     S:后接8位阿拉伯数字公务护照
     G:因私护照G开头
     H:香港特区护照和香港公民所持回乡卡H开头,后接10位数字
     M:澳门特区护照和澳门公民所持回乡卡M开头,后接10位数字
     */
    NSString *regex = @"^1[45][0-9]{7}|([P|p|S|s]\\d{7})|([S|s|G|g]\\d{8})|([Gg|Tt|Ss|Ll|Qq|Dd|Aa|Ff]\\d{8})|([H|h|M|m]\\d{8，10})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject: self];
}

+ (BOOL)validateCarNumber:(NSString *)number {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
    return [carPredicate evaluateWithObject: number];
}

+ (BOOL)validateVerifyCode:(NSString *)verifyCode {
    // 6位纯数字验证码
    NSString *regex = @"^(\\d{6})";
    NSPredicate *verifyCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [verifyCodePredicate evaluateWithObject: verifyCode];
}

+ (BOOL)validateUserName:(NSString *)userName {
    NSString *userNameRegex = @"^[A-Za-z0-9]{4,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    return [userNamePredicate evaluateWithObject: userName];
}

+ (BOOL)validatePassword:(NSString *)password {
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}

+ (BOOL)validatePasswordStrength:(NSString *)password {
    NSString *regex = @"^(?=.*\\d.*)(?=.*[a-zA-Z].*).{6,20}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject: password];
}

+ (BOOL)validateNickName:(NSString *)nickName {
    NSString *nicknameRegex = @"([\u4e00-\u9fa5]{2,5})(&middot;[\u4e00-\u9fa5]{2,5})*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    return [predicate evaluateWithObject: nickName];
}

+ (BOOL)validateBankCardNumber:(NSString *)bankCardNumber {
    NSString *regex = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [bankCardPredicate evaluateWithObject: bankCardNumber];
}

+ (BOOL)validateBankCardLastNumber:(NSString *)bankCardNumber {
    NSString *regex = @"^(\\d{4})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [bankCardPredicate evaluateWithObject: bankCardNumber];
}

+ (BOOL)validateCVNCode:(NSString *)cvnCode {
    NSString *regex = @"^(\\d{3})";
    NSPredicate *cvnCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [cvnCodePredicate evaluateWithObject: cvnCode];
}

+ (BOOL)validateAllEnglish:(NSString *)str {
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject: str];
}

+ (BOOL)validateAllCapitalEnglish:(NSString *)str {
    NSString *regex = @"^[A-Z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject: str];
}

+ (BOOL)validateAllLowercaseEnglish:(NSString *)str {
    NSString *regex = @"^[a-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject: str];
}

+ (BOOL)validateNumberAndEnglish:(NSString *)str {
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject: str];
}

- (NSString *)sortByASCII {
    
    const char *ch = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSMutableArray *ascciArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < strlen(ch); i++) {
        [ascciArray addObject:[NSString stringWithFormat:@"%d", ch[i]]];
    }
    [self shellSort:ascciArray];
    
    NSMutableArray *strArray = [NSMutableArray array];
    for (NSInteger i = 0; i < ascciArray.count; i++) {
        char ascci = [ascciArray[i] integerValue];
        NSString *str = [NSString stringWithFormat:@"%c", ascci];
        [strArray addObject:str];
    }
    
    return [strArray componentsJoinedByString:@""];
}

/**
 希尔排序

 @param list 排序后的数组
 */
-(void)shellSort:(NSMutableArray *)list{
    int gap = (int)list.count / 2;
    while (gap >= 1) {
        for(int i = gap ; i < [list count]; i++){
            NSInteger temp = [[list objectAtIndex:i] intValue];
            int j = i;
            while (j >= gap && temp < [[list objectAtIndex:(j - gap)] intValue]) {
                [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-gap]];
                j -= gap;
            }
            [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        }
        gap = gap / 2;
    }
}

@end
