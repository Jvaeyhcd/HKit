//
//  UITableView+HAdd.m
//  HKit
//
//  Created by Jvaeyhcd on 2019/6/27.
//  Copyright © 2019 STS. All rights reserved.
//

#import "UITableView+HAdd.h"
#import "UIColor+HAdd.h"
#import "UIMacro.h"

@implementation UITableView (HAdd)

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    //适配比5s更大尺寸的屏幕
    cell.bounds = CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, SCREEN_WIDTH, cell.bounds.size.height);
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    CGColorRef lineColor = [UIColor colorWithHexString:@"0xF6F6F6"].CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    //    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    //    CGColorRef sectionLineColor = self.separatorColor.CGColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace{
    [self addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:leftSpace hasSectionLine:YES];
}

- (void)layer:(CALayer *)layer addLineUp:(BOOL)isUp andLong:(BOOL)isLong andColor:(CGColorRef)color andBounds:(CGRect)bounds withLeftSpace:(CGFloat)leftSpace{
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, top;
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
    }else{
        left = leftSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+left, top, bounds.size.width-left, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}

@end
