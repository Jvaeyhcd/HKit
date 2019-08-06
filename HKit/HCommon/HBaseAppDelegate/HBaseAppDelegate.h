//
//  HBaseAppDelegate.h
//  Flower
//
//  Created by 超讯研发部 on 2019/7/3.
//  Copyright © 2019 STS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBaseAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;


/**
 实例
 
 @return 实例对象
 */
+ (instancetype)sharedAppDelegate;

/**
 获取TabBarController
 
 @return 当前TabBarController
 */
- (UITabBarController *)tabBarController;

/**
 获取当前navigationcontroller
 
 @return 当前navigationController
 */
- (UINavigationController *)navigationViewController;

@end

NS_ASSUME_NONNULL_END
