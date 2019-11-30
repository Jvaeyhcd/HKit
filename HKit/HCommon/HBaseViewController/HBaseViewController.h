//
//  HBaseViewController.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/6/28.
//  Copyright © 2019 STS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    NavigationBarItemPositionLeft,
    NavigationBarItemPositionRight,
} NavigationBarItemPosition;

@protocol HBaseViewControllerProtocol <NSObject>

@optional

/**
 点击左边的BarItem
 */
- (void)leftBarItemClicked;

/**
 点击右边的BarItem
 */
- (void)rightBarItemClicked;

@end

@interface HBaseViewController : UIViewController<HBaseViewControllerProtocol>

@end

NS_ASSUME_NONNULL_END
