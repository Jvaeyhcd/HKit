//
//  UIViewController+HAdd.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/7/3.
//  Copyright © 2019 STS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBaseViewController.h"

extern NSString * _Nullable const HViewControllerPropertyChangedNotification;

@protocol HViewControllerPushDelegate <NSObject>

@optional

- (void)pushToNextViewController;

@end

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HAdd)<HBaseViewControllerProtocol>

/**
 设置返回按钮
 */
- (void)showNavBackButton;

/**
 设置图片形式的NavigationBarItem
 
 @param position 位置：左边还是右边
 @param image 按钮图片
 */
- (void)showNavigationBar:(NavigationBarItemPosition)position image:(UIImage *)image;

/**
 设置文字形式的NavigationBarItem
 
 @param position 位置：左边还是右边
 @param title 按钮文字
 */
- (void)showNavigationBar:(NavigationBarItemPosition)position title:(NSString *)title;


/**
 push代理
 */
@property (nonatomic, weak) id<HViewControllerPushDelegate> h_pushDelegate;

@end

NS_ASSUME_NONNULL_END
