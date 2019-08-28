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
- (NSArray *)propertiesArray;

/**
 属性列表
 
 @return 属性列表
 */
+ (NSArray *)propertiesArray;

@end

NS_ASSUME_NONNULL_END
