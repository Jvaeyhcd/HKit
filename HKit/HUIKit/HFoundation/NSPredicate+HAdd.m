//
//  NSPredicate+HAdd.m
//  AFNetworking
//
//  Created by Salvador on 2020/2/3.
//

#import "NSPredicate+HAdd.h"
#import "NSString+HAdd.h"

@implementation NSPredicate (HAdd)

/**
 *  手机号码验证
 *
 *  @param mobileNum 电话号码
 */
+ (BOOL)validateMobile:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,170-179,180,189
     22         */
    NSString * CT = @"^1((33|53|7[0-9]|8[0-9])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return 是否有效
 */

+ (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

/**
 *  验证密码：
 *  1、密码必须由数字、字符两种同时组成；
 *  2、密码长度不能少于6且不能大于16位个字符
 *
 *  @param password 密码
 *
 *  @return 是否有效
 */

+ (BOOL)validatePassword:(NSString *)password{
    NSString *pwdRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pwdPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwdRegex];
    return [pwdPre evaluateWithObject:password];
}

/**
 *  验证身份证
 *
 *  @param number 身份证号码
 *
 *  @return 是否有效
 */
+(BOOL)validateIdentityCard:(NSString *)number{
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (number.length == 15 || number.length == 18) {
        NSString *regex = @"(^\\d{6}((0[48]|[2468][048]|[13579][26])0229|\\d\\d(0[13578]|10|12)(3[01]|[12]\\d|0[1-9])|(0[469]|11)(30|[12]\\d|0[1-9])|(02)(2[0-8]|1\\d|0[1-9]))\\d{3}$)|(^\\d{6}((2000|(19|21)(0[48]|[2468][048]|[13579][26]))0229|(((20|19)\\d\\d)|2100)(0[13578]|10|12)(3[01]|[12]\\d|0[1-9])|(0[469]|11)(30|[12]\\d|0[1-9])|(02)(2[0-8]|1\\d|0[1-9]))\\d{3}[\\dX]$)";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        return [predicate evaluateWithObject:number];
    }else{
        return NO;
    }
}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:[carNo stringByReplacingOccurrencesOfString:@" " withString:@""]];
}

//字母 数字 中文 及一些特殊字符
+ (BOOL)validateChineseLetterMark:(NSString*)sText{
    
    
    if ([NSString isBlankString:sText]) {
        
        return YES;
    }
    NSString *remarkRegex =@"[➋➌➍➎➏➐➑➒0-9a-zA-Z\u4e00-\u9fa5\\.\\*\\)\\(\\+\\$\\[\\?\\\\\\^\\{\\|\\]\\}\\&\\/%%%@\'\",。‘、\\-【】·！_——=:;；<>《》‘’“”!#~]+";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",remarkRegex];
    
    return [passWordPredicate evaluateWithObject:sText];
}

@end
