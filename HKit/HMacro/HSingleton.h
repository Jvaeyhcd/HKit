//
//  HSingleton.h
//  Pods
//
//  Created by Salvador on 2020/1/3.
//

#define SingletonH(methodName) + (instancetype)shared##methodName;

#define SingletonM(methodName) \
static id _instance = nil; \
+ (instancetype)shared##methodName{ \
    return [[self alloc] init]; \
} \
- (instancetype)init{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super init]; \
    }); \
    return _instance; \
} \
+ (id)allocWithZone:(struct _NSZone *)zone{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
- (nonnull id)copyWithZone:(nullable NSZone *)zone { \
    return _instance; \
} \
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone { \
    return _instance; \
} \
