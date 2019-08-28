//
//  NSObject+HRuntime.m
//  DZNEmptyDataSet
//
//  Created by 超讯研发部 on 2019/8/28.
//

#import "NSObject+HRuntime.h"

@implementation NSObject (HRuntime)

- (NSArray *)propertiesArray {
    return [[self class] propertiesArray];
}

+ (NSArray *)propertiesArray {
    
    
    return [NSArray array];
}

@end
