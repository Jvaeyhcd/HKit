//
//  BaseNavigationController.m
//  HKit
//
//  Created by Jvaeyhcd on 2019/6/27.
//  Copyright © 2019 STS. All rights reserved.
//

#import "HBaseNavigationController.h"
#import "UIColor+HAdd.h"
#import "UIView+HAdd.h"
#import "UIMacro.h"

@interface HBaseNavigationController ()

@property (nonatomic, strong) UIView * navLineView;

@end

@implementation HBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self hideBottomBorderInView:self.navigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideBottomBorderInView:self.navigationBar];
    if (nil == _navLineView) {
        _navLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        [_navLineView setBackgroundColor: [UIColor colorWithRGBHex:0xF6F6F6]];
        if (self.haveShadow) {
            [self.navigationBar dropShadowWithOffset:CGSizeMake(0, 3) radius:3 color:[UIColor colorWithRGBHex:0xF0F0F0] opacity:0.8];
        }
        [self.navigationBar addSubview:_navLineView];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/**
 隐藏系统自带的分割线

 @param view 导航栏view
 */
- (void)hideBottomBorderInView: (UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.frame.size.height <= 1.0) {
        [view setHidden:YES];
        [view setBackgroundColor: [UIColor clearColor]];
    }
    
    for (UIView *subview in view.subviews) {
        [self hideBottomBorderInView:subview];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
