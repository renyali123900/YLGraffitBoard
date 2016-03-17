//
//  GraffitiBoardView.m
//  Accumulate
//
//  Created by  haole on 15-3-4.
//  Copyright (c) 2015年 YL. All rights reserved.
//

#import "GraffitiBoardView.h"

@interface ColorBezierPath : UIBezierPath
@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation ColorBezierPath

@end

@interface GraffitiBoardView ()
{
    CGPoint currentPoint;
    NSMutableArray *pathsArray;
    
    BOOL clear;
}
@end

@implementation GraffitiBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        pathsArray = [[NSMutableArray alloc] init];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(clearBoard)];
        [self addGestureRecognizer:pinch];
        
    }
    
    return self;
    
}

- (void)dealloc
{
    pathsArray = nil;

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        pathsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)clearBoard
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [pathsArray removeAllObjects];
    [self setNeedsDisplay];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
        //创建一条线,保存起点
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:self];
    
    ColorBezierPath *path = [[ColorBezierPath alloc] init];
    [path setLineWidth:self.pathWith];
    [path setLineCapStyle:self.lineCap];
    [path setLineJoinStyle: self.linejoin];
    [path setLineColor:self.pathColor];
    
    [path moveToPoint:startPoint];
    [pathsArray addObject:path];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    UIBezierPath *path = [pathsArray lastObject];
    [path addLineToPoint:point];
   
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect
{
    if (clear) {
        CGContextClearRect(UIGraphicsGetCurrentContext(), rect);
        return;
    }

//    CGContextSaveGState(contextRef);  //保存上下文
//    CGContextRestoreGState(contextRef);  //还原保存的上下文  栈空间 保存了才能还原
    for (ColorBezierPath *path in pathsArray) {
 
        [path.lineColor set];
        [path stroke];
    }
    
}

- (void)clear
{
    [pathsArray removeAllObjects];
    [self setNeedsDisplay];
    
}



@end
