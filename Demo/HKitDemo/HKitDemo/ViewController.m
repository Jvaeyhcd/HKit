//
//  ViewController.m
//  HKitDemo
//
//  Created by 超讯研发部 on 2019/8/6.
//  Copyright © 2019 Jvaeyhcd. All rights reserved.
//

#import "ViewController.h"
#import "HKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *answer = @"BCDA";
    answer = [answer sortByASCII];
    NSLog(@"%@", answer);
    
    NSMutableArray *phones = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++) {
        [phones addObject:[self randomPhone]];
    }
    
    for (NSString *mobile in phones) {
        
        BOOL isPhone = [mobile isMobileNumber];
        
        NSLog(@"%@ - %@", mobile, isPhone ? @"是" : @"否");
    }
    
}

- (NSString *)randomPhone {
    NSString *phone = @"1";
    for (NSInteger i = 0; i < 10; i++) {
        int num = arc4random_uniform(10);
        phone = [phone stringByAppendingString:[NSString stringWithFormat:@"%d", num]];
    }
    return phone;
}


@end
