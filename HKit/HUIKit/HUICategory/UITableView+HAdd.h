//
//  UITableView+HAdd.h
//  HKit
//
//  Created by Jvaeyhcd on 2019/6/27.
//  Copyright © 2019 STS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HAdd)

/**
 给Tableview的cell添加线条

 @param cell cell
 @param indexPath indexpath
 @param leftSpace 左边边距
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;


/**
 给Tableview的cell添加线条

 @param cell cell
 @param indexPath indexpath
 @param leftSpace 左边边距
 @param hasSectionLine section事发后显示分割线
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;

@end

NS_ASSUME_NONNULL_END
