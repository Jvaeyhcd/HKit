//
//  HToastUtil.h
//  DZNEmptyDataSet
//
//  Created by Salvador on 2020/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHUDUtil : NSObject

/**
 *  显示提示消息
 */
+ (void)showToast:(NSString *)msg;

/// 显示加载
+ (void)showLoading;

/// 隐藏加载
+ (void)hideLoading;

@end

NS_ASSUME_NONNULL_END
