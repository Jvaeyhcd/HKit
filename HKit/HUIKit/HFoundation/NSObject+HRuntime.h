//
//  NSObject+HRuntime.h
//  DZNEmptyDataSet
//
//  Created by 超讯研发部 on 2019/8/28.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HRuntime)

/**
 属性列表

 @return 属性列表
 */
- (NSArray *)propertiesList;

/**
 属性列表
 
 @return 属性列表
 */
+ (NSArray *)propertiesList;

/**
 成员变量列表

 @return 成员变量列表
 */
- (NSArray *)ivarList;

/**
 成员变量列表

 @return 成员变量列表
 */
+ (NSArray *)ivarList;

/**
 对象方法列表

 @return 对象方法列表
 */
- (NSArray *)instanceMethodList;

/**
 对象方法列表

 @return 对象方法列表
 */
+ (NSArray *)instanceMethodList;

/**
 类方法列表
 
 @return 类方法列表
 */
- (NSArray *)classMethodList;

/**
 类方法列表

 @return 类方法列表
 */
+ (NSArray *)classMethodList;

/**
 协议列表

 @return 协议列表
 */
- (NSDictionary *)protocolInfo;

/**
 协议列表

 @return 协议列表
 */
+ (NSDictionary *)protocolInfo;

/**
 交换实例方法

 @param oldMethod 交换前的旧方法
 @param newMethod 交换后的新方法
 */
+ (void)swizzlingInstanceMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

/**
 交换类方法

 @param oldMethod 交换前的旧方法
 @param newMethod 交换后的新方法
 */
+ (void)swizzlingClassMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

/**
 根据JSON字典初始化对象

 @param dict 字典
 @return 初始化对象
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
