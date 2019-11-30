//
//  HUtils.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/7/11.
//  Copyright © 2019 STS. All rights reserved.
//

#import <objc/runtime.h>

#ifndef HUtils_h
#define HUtils_h

/**
 使用static inline创建静态内联函数，方便调用

 @param cls 类对象
 @param originalSelector 原始方法
 @param swizzledSelector 交换后的方法
 */
static inline void h_swizzled_method(Class cls ,SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL isAdd = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdd) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#endif /* HUtils_h */
