//
//  GraffitiBoardView.h
//  Accumulate
//
//  Created by  haole on 15-3-4.
//  Copyright (c) 2015年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 自定义的涂鸦view 通过 UIBezierPath 渲染线条 
 *pathColor   线颜色
 *pathWidth   线宽
 *lineCap     线两端样式
 *linejoin    线拐角样式
 */

@interface GraffitiBoardView : UIView

@property (nonatomic, strong) UIColor *pathColor;
@property (nonatomic, assign) CGFloat pathWith;
@property (nonatomic, assign) CGLineCap lineCap;
@property (nonatomic, assign) CGLineJoin linejoin;

- (void)clear;
@end
