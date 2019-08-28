//
//  UIScrollView+HAdd.m
//  Flower
//
//  Created by 超讯研发部 on 2019/7/19.
//  Copyright © 2019 STS. All rights reserved.
//

#import "UIScrollView+HAdd.h"
#import <MJRefresh/MJRefresh.h>
#import <objc/runtime.h>

static const void *kClickBlock = @"clickBlock";
static const void *kEmptyText = @"emptyText";
static const void *kEmptyDataOffset = @"emptyDataOffset";
static const void *kEmptyImage = @"emptyImage";

@implementation UIScrollView (HAdd)

#pragma mark - MJRefresh 封装

- (void)setRefreshWithHeaderBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    
    if (headerBlock) {
        
        MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (headerBlock) {
                headerBlock();
            }
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.mj_header = header;
    }
    
    if (footerBlock) {
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }];
        [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden = NO;
        self.mj_footer = footer;
    }
    
}

- (void)headerBeginRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)headerEndRefreshing {
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing {
    [self.mj_footer endRefreshing];
}

- (void)footerNoMoreData {
    [self.mj_footer setState:MJRefreshStateNoMoreData];
}

- (void)endRefreshingWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)hideFooterRefresh {
    self.mj_footer.hidden = YES;
}

- (void)hideHeaderRefresh {
    self.mj_header.hidden = YES;
}

#pragma mark - 设置空数据页面

- (ClickBlock)clickBlock {
    return objc_getAssociatedObject(self, &kClickBlock);
}

- (void)setClickBlock:(ClickBlock)clickBlock {
    objc_setAssociatedObject(self, &kClickBlock, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)emptyText {
    return objc_getAssociatedObject(self, &kEmptyText);
}

- (void)setEmptyText:(NSString *)emptyText {
    objc_setAssociatedObject(self, &kEmptyText, emptyText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)emptyDataOffset {
    NSNumber *number = objc_getAssociatedObject(self, &kEmptyDataOffset);
    return number.floatValue;
}

- (void)setEmptyDataOffset:(CGFloat)emptyDataOffset {
    NSNumber *number = [NSNumber numberWithDouble:emptyDataOffset];
    objc_setAssociatedObject(self, &kEmptyDataOffset, number, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)emptyImage {
    return objc_getAssociatedObject(self, &kEmptyImage);
}

- (void)setEmptyImage:(NSString *)emptyImage {
    objc_setAssociatedObject(self, &kEmptyImage, emptyImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setupEmptyData:(ClickBlock)clickBlock {
    
    self.clickBlock = clickBlock;
    self.emptyDataSetSource = self;
    if (clickBlock) {
        self.emptyDataSetDelegate = self;
    }
}

- (void)setupEmptyDataText:(NSString *)text clickBlock:(ClickBlock)clickBlock {
    
    self.clickBlock = clickBlock;
    self.emptyText = text;
    
    self.emptyDataSetSource = self;
    if (clickBlock) {
        self.emptyDataSetDelegate = self;
    }
}

- (void)setupEmptyDataText:(NSString *)text emptyDataOffset:(CGFloat)emptyDataOffset clickBlock:(ClickBlock)clickBlock {
    
    self.clickBlock = clickBlock;
    self.emptyText = text;
    self.emptyDataOffset = emptyDataOffset;
    
    self.emptyDataSetSource = self;
    if (clickBlock) {
        self.emptyDataSetDelegate = self;
    }
}

- (void)setupEmptyDataText:(NSString *)text emptyDataOffset:(CGFloat)emptyDataOffset emptyImage:(UIImage *)emptyImage clickBlock:(ClickBlock)clickBlock {
    
    self.clickBlock = clickBlock;
    self.emptyText = text;
    self.emptyDataOffset = emptyDataOffset;
    self.emptyImage = emptyImage;
    
    self.emptyDataSetSource = self;
    if (clickBlock) {
        self.emptyDataSetDelegate = self;
    }
}

#pragma mark - DZNEmptyDataSetSource

// 空白界面的标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = self.emptyText ?: @"没有找到任何数据";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 5;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

// 空白页的图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyImage ?: [UIImage imageNamed:@"empty_image"];
}

//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return NO;
}

// 垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    NSLog(@"offset   %f",self.emptyDataOffset);
    return self.emptyDataOffset;
}


#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
