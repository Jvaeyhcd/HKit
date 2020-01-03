//
//  HSandbox.h
//  DZNEmptyDataSet
//
//  Created by Salvador on 2020/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSandbox : NSObject

/// 程序目录，不能存任何东西
+ (NSString *)appPath;

/// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)docPath;

/// libary目录
+ (NSString *)libPath;

/// 配置目录，配置文件存这里
+ (NSString *)libPrefPath;

/// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)libCachePath;

/// 缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)tmpPath;

@end

NS_ASSUME_NONNULL_END
