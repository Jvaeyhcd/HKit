//
//  HRouter.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/7/3.
//  Copyright © 2019 STS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HRouterProtocol;
@interface HRouter : NSObject

/**
 *  路由
 */
+ (void)routeToUrl:(NSString *)url;
+ (void)routeToUrl:(NSString *)url param:(NSDictionary *)param;

/**
 *  模态显示
 */
+ (void)presentUrl:(NSString *)url animated:(BOOL)animated completion:(void (^)(void))completion;
+ (void)presentUrl:(NSString *)url animated:(BOOL)animated param:(NSDictionary *)param completion:(void (^)(void))completion;
+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
+ (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion;

/**
 *  通过safari打开链接
 */
+ (BOOL)openUrlInSafari:(NSString *)openUrl;


+ (UITabBarController *)rootTabBarController;
+ (UINavigationController *)topNavigationController;

@end

/**
 *  需要路由的ViewController需要实现此协议
 */
@protocol HRouterProtocol <NSObject>

@required
/**
 *  创建需要路由的ViewController
 */
- (UIViewController *)initForRouterWithUrl:(NSString *)url param:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
