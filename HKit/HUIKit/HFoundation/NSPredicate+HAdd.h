//
//  NSPredicate+HAdd.h
//  AFNetworking
//
//  Created by Salvador on 2020/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPredicate (HAdd)

/**
 *  手机号码验证
 *
 *  @param mobileNum 电话号码
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;

/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return 是否有效
 */

+ (BOOL)validateEmail:(NSString *)email;

/**
 *  验证密码：
 *  1、密码必须由数字、字符、特殊字符三种中的两种组成；
 *  2、密码长度不能少于6个字符
 *
 *  @param password 密码
 *
 *  @return 是否有效
 */

+ (BOOL)validatePassword:(NSString *)password;

/**
 *  验证身份证
 *
 *  @param number 身份证号码
 *
 *  @return 是否有效
 */
+(BOOL)validateIdentityCard:(NSString *)number;

/**
 *  车牌号验证（未完善）
 *
 *  @param carNo 车牌号
 *
 *  @return 是否有效
 */
+ (BOOL) validateCarNo:(NSString *)carNo;

//字母 数字 中文 及一些特殊字符
+ (BOOL)validateChineseLetterMark:(NSString*)sText;

@end

NS_ASSUME_NONNULL_END
