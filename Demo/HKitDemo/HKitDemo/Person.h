//
//  Person.h
//  HKitDemo
//
//  Created by 超讯研发部 on 2019/8/29.
//  Copyright © 2019 Jvaeyhcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HKit/HKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *sex;

- (void)eat;

+ (void)work;

@end

NS_ASSUME_NONNULL_END
