//
//  ViewController.m
//  HKitDemo
//
//  Created by Jvaeyhcd on 2019/8/30.
//  Copyright © 2019 Jvaeyhcd. All rights reserved.
//

#import "ViewController.h"
#import "HKit.h"

@interface ViewController ()<HNavigationControllerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"HKitDemo";

    UIButton *btn = [UIButton initButtonWithText:@"Push" textColor:[UIColor colorWithRGBHex:0xFFFFFF] bgColor:[UIColor colorWithRGBHex:0xFF00FF] font:[UIFont systemFontOfSize:14]];
    btn.frame = CGRectMake(SCREEN_WIDTH / 2 - 40, SCREEN_HEIGHT / 2 - 20, 80, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pushNewViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.h_navigationDelegate = self;
}

- (void)pushNewViewController {
    HBaseViewController *vc = [[HBaseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
