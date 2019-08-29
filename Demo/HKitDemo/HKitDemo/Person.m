//
//  Person.m
//  HKitDemo
//
//  Created by 超讯研发部 on 2019/8/29.
//  Copyright © 2019 Jvaeyhcd. All rights reserved.
//

#import "Person.h"

@interface Person() {
    NSString *_birthDay;
}

@end

@implementation Person

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [Person swizzlingInstanceMethod:@selector(eat) newMethod:@selector(swizzledEat)];
        [Person swizzlingClassMethod:@selector(work) newMethod:@selector(swizzledWork)];
    });
}

+ (void)initialize
{
    if (self == [Person class]) {
        
    }
}

- (void)eat {
    NSLog(@"Person eat");
}

- (void)swizzledEat {
    NSLog(@"Person swizzledEat");
}

+ (void)work {
    NSLog(@"Person work");
}

+ (void)swizzledWork {
    NSLog(@"Person swizzledWork");
}

@end
