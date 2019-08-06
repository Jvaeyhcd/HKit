//
//  UIViewController+HAdd.m
//  Flower
//
//  Created by 超讯研发部 on 2019/7/3.
//  Copyright © 2019 STS. All rights reserved.
//

#import "UIViewController+HAdd.h"
#import "NSString+HAdd.h"
#import "UIColor+HAdd.h"
#import <objc/runtime.h>
#import "HUtils.h"
#import "UIMacro.h"

NSString *const HViewControllerPropertyChangedNotification = @"HViewControllerPropertyChangedNotification";

static const void* HPushDelegateKey    = @"HPushDelegateKey";

@implementation UIViewController (HAdd)

+ (void)load {
    // 保证其只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        h_swizzled_method(class, @selector(viewDidAppear:) ,@selector(h_viewDidAppear:));
        
        if (@available(iOS 11.0, *)) {
            h_swizzled_method(class, @selector(viewWillAppear:), @selector(h_viewWillAppear:));
        }
    });
}

- (void)h_viewWillAppear:(BOOL)animated {
    
}

- (void)h_viewDidAppear:(BOOL)animated {
    
}

- (void)showNavBackButton {
    [self showNavigationBar:NavigationBarItemPositionLeft image:[UIImage imageNamed:@"icon_back"]];
}

- (void)showNavigationBar:(NavigationBarItemPosition)position image:(UIImage *)image {
    
    if (NavigationBarItemPositionLeft == position) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemClicked)];
        item.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem = item;
    } else if (NavigationBarItemPositionRight == position) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClicked)];
        item.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem = item;
    }
    
}

- (void)showNavigationBar:(NavigationBarItemPosition)position title:(NSString *)title {
    
    CGFloat width = [title widthWithConstainedWidth:SCREEN_WIDTH / 3 font: [UIFont systemFontOfSize:12]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRGBHex:0x333333] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRGBHex:0xBDBDBD] forState:UIControlStateDisabled];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    if (NavigationBarItemPositionLeft == position) {
        self.navigationItem.leftBarButtonItem = item;
        [btn addTarget:self action:@selector(leftBarItemClicked) forControlEvents:UIControlEventTouchUpInside];
    } else if (NavigationBarItemPositionRight == position) {
        self.navigationItem.rightBarButtonItem = item;
        [btn addTarget:self action:@selector(rightBarItemClicked) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (id<HViewControllerPushDelegate>)h_pushDelegate {
    return objc_getAssociatedObject(self, HPushDelegateKey);
}

- (void)setH_pushDelegate:(id<HViewControllerPushDelegate>)h_pushDelegate {
    objc_setAssociatedObject(self, HPushDelegateKey, h_pushDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)leftBarItemClicked {
    
}

- (void)rightBarItemClicked {
    
}

@end
