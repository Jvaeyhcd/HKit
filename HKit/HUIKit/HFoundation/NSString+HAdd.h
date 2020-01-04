//
//  NSString+HAdd.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/7/3.
//  Copyright © 2019 STS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HAdd)

/**
 计算约束条件下的文字宽度

 @param width 约束文字宽度
 @param font 字体大小
 @return 真实宽度
 */
- (CGFloat)widthWithConstainedWidth:(CGFloat)width font:(UIFont *)font;

/**
 计算约束条件下的文字尺寸

 @param size 约束文字尺寸
 @param font 文字字体大小
 @return 真实尺寸
 */
- (CGSize)sizeWithConstainedSize:(CGSize)size font:(UIFont *)font;

/**
 是否是空字符串，nil、''、"   "都是空字符串

 @return YES or NO
 */
+ (BOOL)isBlankString:(NSString *)str;

/**
 字符串空格判断

 @return YES or NO
 */
- (BOOL)haveEmptySpace;

/**
 字符串长度验证

 @param maxLength 最大长度
 @param minLength 最小长度
 @return YES or NO
 */
- (BOOL)paraStringLength:(NSInteger)maxLength minLength:(NSInteger)minLength;

/**
 身份证号验证
 @return YES or NO
 */
- (BOOL)isIDCardNumber;

/**
 首元素为字母
 @return YES or NO
 */
- (BOOL)firstIsLetter;

/**
 验证是否是邮箱地址
 @return YES or NO
 */
- (BOOL)isEmail;

/**
 验证是否是手机号码
 @return YES or NO
 */
- (BOOL)isMobileNumber;

/**
 验证是否是网址链接
 @return YES or NO
 */
- (BOOL)isHttpRequestUrl;

/**
 验证是否是护照号码
 @return YES or NO
 */
- (BOOL)isPassportNumber;

/**
 * 验证是否是用户名
 @param userName 用户名
 @return YES or NO
 */
+ (BOOL)validateUserName:(NSString *)userName;

/**
 * 密码验证6~20位正则表达式
 * 密码由 数字与字母组合
 @param password 密码
 @return YES or NO
 */
+ (BOOL)validatePassword:(NSString *)password;

/**
 * 密码强度正则表达式
 * 必须是强密码，包含大小写字母、数字和特殊符号
 @param password 密码
 @return YES or NO
 */
+ (BOOL)validatePasswordStrength:(NSString *)password;


/**
 验证验证码正则表达式

 @param verifyCode 验证码
 @return YES or NO
 */
+ (BOOL)validateVerifyCode:(NSString *)verifyCode;

/**
 验证昵称

 @param nickName 昵称
 @return YES or NO
 */
+ (BOOL)validateNickName:(NSString *)nickName;

/**
 验证银行卡号

 @param bankCardNumber 银行卡号
 @return YES or NO
 */
+ (BOOL)validateBankCardNumber:(NSString *)bankCardNumber;

/**
 验证银行卡后四位

 @param bankCardNumber 银行卡后四位
 @return YES or NO
 */
+ (BOOL)validateBankCardLastNumber:(NSString *)bankCardNumber;

/**
 CVN验证

 @param cvnCode CVN码
 @return YES or NO
 */
+ (BOOL)validateCVNCode:(NSString *)cvnCode;

/**
 车牌号码验证

 @param number 车牌号
 @return YES or NO
 */
+ (BOOL)validateCarNumber:(NSString *)number;

/**
 全英文正则表达验证

 @param str 待验证的字符串
 @return YES or NO
 */
+ (BOOL)validateAllEnglish:(NSString *)str;

/**
 全大写英文正则表达式

 @param str 待验证的字符串
 @return YES or NO
 */
+ (BOOL)validateAllCapitalEnglish:(NSString *)str;

/**
 全小写英文正则表达式

 @param str 待验证的字符串
 @return YES or NO
 */
+ (BOOL)validateAllLowercaseEnglish:(NSString *)str;

/**
 英文数字正则表达式

 @param str 目标字符串
 @return YES or NO
 */
+ (BOOL)validateNumberAndEnglish:(NSString *)str;

/**
 字符串根据ASCII码排序

 @return 排序后的字符串
 */
- (NSString *)sortByASCII;

@end

NS_ASSUME_NONNULL_END
