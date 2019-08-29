//
//  ViewController.m
//  HKitDemo
//
//  Created by 超讯研发部 on 2019/8/6.
//  Copyright © 2019 Jvaeyhcd. All rights reserved.
//

#import "ViewController.h"
#import "HKit.h"
#import "Person.h"

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
    
    NSString *str10 = @"11111111111111111111"; // __NSCFConstantString
    NSString *str11 = [NSString stringWithFormat:@"aaaaaaaaaaaa"]; // NSTaggedPointerString
    NSString *str12 = [NSString stringWithFormat:@"j98883399012ssssssssssssssssssssss"]; // __NSCFString
    
    NSMutableString *str20 = [NSMutableString stringWithFormat:@"1111111111111"];
    [str20 appendFormat:@"111111111111%@", str12];
    
    NSLog(@"%@-%@-%@-%@", str10, str11, str12, str20);
    
    NSDictionary *dict = @{@"name": @"Jvaeyhcd", @"age": @10, @"sex": @"man", @"nickName": @"Huang"};
    
    Person *person = [[Person alloc] initWithDict:dict];
    [person eat];
    [Person work];
    
//    NSDictionary *array = [Person protocolInfo];
//    NSLog(@"%@", array);
    
//
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_group_async(group, queue, ^{
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        NSLog(@"task1 begin : %@",[NSThread currentThread]);
//        dispatch_async(queue, ^{
//            NSLog(@"task1 finish : %@",[NSThread currentThread]);
//            dispatch_semaphore_signal(sema);
//        });
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//    });
//    dispatch_group_async(group, queue, ^{
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        NSLog(@"task2 begin : %@",[NSThread currentThread]);
//        sleep(1);
//        dispatch_async(queue, ^{
//            NSLog(@"task2 finish : %@",[NSThread currentThread]);
//            dispatch_semaphore_signal(sema);
//        });
//
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"refresh UI");
//    });
//
//    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:100];
//
//    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
//    for (int i = 0; i < 10000; i++) {
//        dispatch_async(queue1, ^{
//            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//            [array addObject:[NSNumber numberWithInt:i]];
//            NSLog(@"%@",[NSNumber numberWithInt:i]);
//            dispatch_semaphore_signal(sem);
//        });
//    }
//    NSLog(@"---");
    
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:100];
//    // 创建队列组
//    dispatch_group_t group = dispatch_group_create();
//    // 创建信号量，并且设置值为10
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    for (int i = 0; i < 100; i++)
//    {   // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_group_async(group, queue, ^{
//            NSLog(@"%i",i);
//            [array addObject:[NSNumber numberWithInt:i]];
////            sleep(2);
//            // 每次发送信号则semaphore会+1，
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
//
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"Done, array = %@", array);
//    });
//
//    NSLog(@"---");
    
    [self testGroup];
}

/** 串行同步 */
- (void)syncSerial {
    
    NSLog(@"\n\n**************串行同步***************\n\n");
    
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    // 同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行同步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行同步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行同步3   %@",[NSThread currentThread]);
        }
    });
}

/** 串行异步 */
- (void)asyncSerial {
    
    NSLog(@"\n\n**************串行异步***************\n\n");
    
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    // 同步执行
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步3   %@",[NSThread currentThread]);
        }
    });
}

/** 并发同步 */
- (void)syncConcurrent {
    
    NSLog(@"\n\n**************并发同步***************\n\n");
    
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步3   %@",[NSThread currentThread]);
        }
    });
}

/** 并发异步 */
- (void)asyncConcurrent {
    
    NSLog(@"\n\n**************并发异步***************\n\n");
    
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 同步执行
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步3   %@",[NSThread currentThread]);
        }
    });
}

/** 主队列同步 */
- (void)syncMain {
    
    NSLog(@"\n\n**************主队列同步，放到主线程会死锁***************\n\n");
    
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步3   %@",[NSThread currentThread]);
        }
    });
}

/** 主队列异步 */
- (void)asyncMain {
    
    NSLog(@"\n\n**************主队列异步***************\n\n");
    
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列异步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列异步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列异步3   %@",[NSThread currentThread]);
        }
    });
}

- (void)testGroup {
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：有一个耗时操作完成！ %@",[NSThread currentThread]);
        sleep(2);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：有一个耗时操作完成！ %@",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"队列组：前面的耗时操作都完成了，回到主线程进行相关操作");
    });
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
