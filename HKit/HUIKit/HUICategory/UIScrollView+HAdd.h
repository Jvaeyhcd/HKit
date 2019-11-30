//
//  UIScrollView+HAdd.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/7/19.
//  Copyright © 2019 STS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef void(^ClickBlock)();

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (HAdd)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


/**
 设置下拉刷新和加载更多回调

 @param headerBlock 下拉刷新
 @param footerBlock 加载更多刷新
 */
- (void)setRefreshWithHeaderBlock:(void(^)(void))headerBlock
                      footerBlock:(void(^)(void))footerBlock;


/**
 开始下拉刷新
 */
- (void)headerBeginRefreshing;

/**
 停止下拉刷新
 */
- (void)headerEndRefreshing;

/**
 停止加载更多
 */
- (void)footerEndRefreshing;

/**
 没有更多数据
 */
- (void)footerNoMoreData;

/**
 停止刷新并设置没有更多数据
 */
- (void)endRefreshingWithNoMoreData;

/**
 隐藏下拉刷新
 */
- (void)hideHeaderRefresh;

/**
 隐藏加载更多
 */
- (void)hideFooterRefresh;

/******************设置空数据页面******************/

/**
 点击事件，（重新加载）
 */
@property (nonatomic, copy) ClickBlock clickBlock;

/**
 空数据页面垂直偏移
 */
@property (nonatomic, assign) CGFloat emptyDataOffset;

/**
 空数据页面文字
 */
@property (nonatomic, copy) NSString *emptyText;

/**
 空数据页面图片
 */
@property (nonatomic, strong) UIImage *emptyImage;

- (void)setupEmptyData:(ClickBlock)clickBlock;

- (void)setupEmptyDataText:(NSString *)text clickBlock:(ClickBlock)clickBlock;

- (void)setupEmptyDataText:(NSString *)text emptyDataOffset:(CGFloat)emptyDataOffset clickBlock:(ClickBlock)clickBlock;

- (void)setupEmptyDataText:(NSString *)text emptyDataOffset:(CGFloat)emptyDataOffset emptyImage:(UIImage *)emptyImage clickBlock:(ClickBlock)clickBlock;

@end

NS_ASSUME_NONNULL_END
