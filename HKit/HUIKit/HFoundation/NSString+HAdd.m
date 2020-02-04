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

+ (BOOL)validateIDCardNumber:(NSString *)idCardNumber {
    
    idCardNumber = [idCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!idCardNumber) {
        return NO;
    }else {
        length = idCardNumber.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [idCardNumber substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [idCardNumber substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            }else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber options:NSMatchingReportProgress range:NSMakeRange(0, idCardNumber.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [idCardNumber substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber options:NSMatchingReportProgress range:NSMakeRange(0, idCardNumber.length)];
            
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [idCardNumber substringWithRange:NSMakeRange(0,1)].intValue*7 + [idCardNumber substringWithRange:NSMakeRange(10,1)].intValue *7 + [idCardNumber substringWithRange:NSMakeRange(1,1)].intValue*9 + [idCardNumber substringWithRange:NSMakeRange(11,1)].intValue *9 + [idCardNumber substringWithRange:NSMakeRange(2,1)].intValue*10 + [idCardNumber substringWithRange:NSMakeRange(12,1)].intValue *10 + [idCardNumber substringWithRange:NSMakeRange(3,1)].intValue*5 + [idCardNumber substringWithRange:NSMakeRange(13,1)].intValue *5 + [idCardNumber substringWithRange:NSMakeRange(4,1)].intValue*8 + [idCardNumber substringWithRange:NSMakeRange(14,1)].intValue *8 + [idCardNumber substringWithRange:NSMakeRange(5,1)].intValue*4 + [idCardNumber substringWithRange:NSMakeRange(15,1)].intValue *4 + [idCardNumber substringWithRange:NSMakeRange(6,1)].intValue*2 + [idCardNumber substringWithRange:NSMakeRange(16,1)].intValue *2 + [idCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                
                NSString *lastStr = [idCardNumber substringWithRange:NSMakeRange(17,1)];
                
                NSLog(@"%@",M);
                NSLog(@"%@",[idCardNumber substringWithRange:NSMakeRange(17,1)]);
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else{
                        
                        return NO;
                    }
                }else{
                    
                    if ([M isEqualToString:[idCardNumber substringWithRange:NSMakeRange(17,1)]]) {
                        return YES;
                    }else {
                        return NO;
                    }
                    
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
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

/**
 判断字符串个数 中文算2个 英文算一个
 */
- (NSInteger)characterCounts{
    NSInteger  character = 0;
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fa5){ //判断是否为中文
            character +=2;
        }else{
            character +=1;
        }
    }
    return character;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (NSUInteger)charactorNumber
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self charactorNumberWithEncoding:encoding];
}

- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding
{
    NSUInteger strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:encoding];
    
    NSUInteger lengthOfBytes = [self lengthOfBytesUsingEncoding:encoding];
    for (int i = 0; i < lengthOfBytes; i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

- (NSString *)subStringByByteWithIndex:(NSInteger)index{
    
    NSInteger sum = 0;
    NSString *subStr = [[NSString alloc] init];
    
    for(int i = 0; i<[self length]; i++){
        
        unichar strChar = [self characterAtIndex:i];
        if(strChar < 256){
            sum += 1;
        } else {
            sum += 2;
        }
        if (sum >= index) {
            subStr = [self substringToIndex:i+1];
            return subStr;
        }
    }
    
    return subStr;
}

@end
