//
//  UINavigationController+HFullscreenPopGesture.h
//  DZNEmptyDataSet
//
//  Created by Salvador on 2019/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HNavigationControllerDelegate;

@interface UINavigationController (HFullscreenPopGesture)

/// The gesture recognizer that actually handles interactive pop.
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *h_fullScreenPopGestureRecognizer;

/// A view controller is able to control navigation bar's appearance by itself,
/// rather than a global way
/// Default is YES
@property (nonatomic, assign) BOOL h_viewControllerBasedNavigationBarAppearanceEnabled;

/// Delegate to observe delegate events.
/// @see HNavigationControllerDelegate
@property (nonatomic, weak) id<HNavigationControllerDelegate> h_navigationDelegate;

@end


/// Allows any view controller to disable interactive pop gesture, which might
/// be necessary when the view controller itself handles pan gesture in some case.
@interface UIViewController (HFullscreenPopGesture)

/// Whether the interactive pop gesture is disabled when contained in a navigation stack.
@property (nonatomic, assign) BOOL h_interactivePopDisable;

/// Indicate the view controller prefers it's navigation bar hidden or not,
/// check when view controller based navigation bar's appearance is enabled.
/// Default is NO
@property (nonatomic, assign) BOOL h_prefersNavigationBarHidden;

/// Max allowed initial distance to left edge when you begin the interactive pop gesture.
/// 0 by default, which means it will ignore this limit.
@property (nonatomic, assign) CGFloat h_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end

/// Just follow the HNavigationControllerDelegate protocol and override the delegate method in this protocol.
/// use [self.navigationController pushViewController:aVc animated:YES]
/// if need push gesture transition animation when left slip.
/// You should preload the data of next viewController need to display for a good experience.
@protocol HNavigationControllerDelegate <NSObject>

@optional

/// The delegate method need to override if need gesture transition animation when left slip.
///
/// @param navigationController the root navigation controller.
- (void)navigationControllerDidPush:(UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END
