//
//  UINavigationController+HFullscreenPopGesture.m
//  DZNEmptyDataSet
//
//  Created by Salvador on 2019/11/29.
//

#import "UINavigationController+HFullscreenPopGesture.h"
#import <objc/runtime.h>

@interface _HFullscreenPopGestureRecognizerDelegate : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation _HFullscreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // Ignore gesture when no view controller is pushed into the navigation stack.
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    // Ignore gesture when the active view controller doesn't allow interactive pop.
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.h_interactivePopDisable) {
        return NO;
    }
    
    // Ignore gesture when the begin location is beyond max allowed initial distance to left edge.
    CGPoint beginLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.h_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    if (maxAllowedInitialDistance > 0 && beginLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
        BOOL isLeftToRight = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;
        
        if (isLeftToRight) {
            NSLog(@"gesture left to right");
        } else {
            NSLog(@"gesture right to left");
        }
        
        CGFloat multiplier = isLeftToRight ? 1 : -1;
        if (translation.x * multiplier <= 0) {
            return NO;
        }
        
    }
    
    return YES;
}

@end

typedef void (^_HViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

/// UIViewController's private category
@interface UIViewController (HFullscreenPopGesturePrivate)

@property (nonatomic, copy) _HViewControllerWillAppearInjectBlock h_willAppearInjectBlock;

@end

@implementation UIViewController (HFullscreenPopGesturePrivate)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewWillAppear_originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method viewWillAppear_swizzledMethod = class_getInstanceMethod(self, @selector(h_viewWillAppear:));
        method_exchangeImplementations(viewWillAppear_originalMethod, viewWillAppear_swizzledMethod);
        
        Method viewWillDisappear_originalMethod = class_getInstanceMethod(self, @selector(viewWillDisappear:));
        Method viewWillDisappear_swizzledMethod = class_getInstanceMethod(self, @selector(h_viewWillDisappear:));
        method_exchangeImplementations(viewWillDisappear_originalMethod, viewWillDisappear_swizzledMethod);
    });
}

- (void)h_viewWillAppear:(BOOL)animated {
    // Forward to primary implementation.
    [self h_viewWillAppear:animated];
    
    if (self.h_willAppearInjectBlock) {
        self.h_willAppearInjectBlock(self, animated);
    }
}

- (void)h_viewWillDisappear:(BOOL)animated {
    // Forward to primary implementation.
    [self h_viewWillDisappear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *viewController = self.navigationController.viewControllers.lastObject;
        if (viewController && !viewController.h_prefersNavigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:NO];;
        }
    });
}

- (_HViewControllerWillAppearInjectBlock)h_willAppearInjectBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setH_willAppearInjectBlock:(_HViewControllerWillAppearInjectBlock)h_willAppearInjectBlock {
    objc_setAssociatedObject(self, @selector(h_willAppearInjectBlock), h_willAppearInjectBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation UIViewController (HFullscreenPopGesture)

- (BOOL)h_interactivePopDisable {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setH_interactivePopDisable:(BOOL)disable {
    objc_setAssociatedObject(self, @selector(h_interactivePopDisable), @(disable), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)h_prefersNavigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setH_prefersNavigationBarHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(h_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)h_interactivePopMaxAllowedInitialDistanceToLeftEdge {
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setH_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance {
    SEL key = @selector(h_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation UINavigationController (HFullscreenPopGesture)

+ (void)load {
    
    // Inject "-pushViewConontroller:animated:"
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(h_pushViewController:animated:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)h_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.h_fullScreenPopGestureRecognizer]) {
        
        // Add our gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.h_fullScreenPopGestureRecognizer];
        
        // Forward the gesture events to the private handler of the onboard gesture recognizer.
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.h_fullScreenPopGestureRecognizer.delegate = self.h_popGestureRecognizerDelegate;
        [self.h_fullScreenPopGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // Disable the onboard gesture appearance.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Handle perfered navigation bar appearance.
    [self h_setupViewControllerBaseNavigationBarAppearanceIfNeeded:viewController];
    
    // Foorward to primary implementation.
    if (![self.viewControllers containsObject:viewController]) {
        [self h_pushViewController:viewController animated:animated];
    }
}

- (void)h_setupViewControllerBaseNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController {
    if (!self.h_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _HViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.h_prefersNavigationBarHidden animated:animated];
        }
    };
    
    // Setup will appear inject block to appearing view controller.
    // Setup disappearing view controller, because not every view controller is added into stack by pushing, maybe by "-setViewControllers:"
    appearingViewController.h_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.h_willAppearInjectBlock) {
        disappearingViewController.h_willAppearInjectBlock = block;
    }
}

// getter
- (_HFullscreenPopGestureRecognizerDelegate *)h_popGestureRecognizerDelegate {
    _HFullscreenPopGestureRecognizerDelegate *delegate =objc_getAssociatedObject(self, _cmd);
    
    if (!delegate) {
        delegate = [[_HFullscreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIPanGestureRecognizer *)h_fullScreenPopGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return panGestureRecognizer;
}

- (BOOL)h_viewControllerBasedNavigationBarAppearanceEnabled {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    // Set default value YES.
    self.h_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setH_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled {
    SEL key = @selector(h_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<HNavigationControllerDelegate>)h_navigationDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setH_navigationDelegate:(id<HNavigationControllerDelegate>)delegate {
    objc_setAssociatedObject(self, @selector(h_navigationDelegate), delegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
