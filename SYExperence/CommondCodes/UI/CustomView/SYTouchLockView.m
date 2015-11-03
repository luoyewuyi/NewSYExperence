//
//  SYTouchLockView.m
//  SYExperence
//
//  Created by yuhang on 15/9/24.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYTouchLockView.h"
#import "SYCircleView.h"

#define sCirclesCount           9
#define sColumn                 3       // 行
#define sRow                    ((sCirclesCount+sColumn-1)/sColumn)

#define sCircleSize             74

#define sLineColor              [UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5]


#define sBackgroundColor        [UIColor colorWithRed:10/255.0 green:100/255.0 blue:10/255.0 alpha:1]

@interface SYTouchLockView ()
{
    
}

@property (nonatomic, strong)   NSMutableArray* selectedPoints;

@property (nonatomic, assign)   CGPoint         currentPoint;

@end

@implementation SYTouchLockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup
{
    for (int i=0; i<sCirclesCount; i++)
    {
        SYCircleView* circle = [SYCircleView buttonWithType:UIButtonTypeCustom];
        [self addSubview:circle];
        circle.tag = i;
        [self addSubview:circle];
    }
    self.backgroundColor = sBackgroundColor;
}

- (NSMutableArray *)selectedPoints
{
    if (_selectedPoints == nil)
    {
        _selectedPoints = [NSMutableArray array];
    }
    return _selectedPoints;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //
    CGFloat rcW = self.frame.size.width;
    CGFloat rcH = self.frame.size.height;
    //
    CGFloat marginX = (rcW-sColumn*sCircleSize)/(sColumn+1);
    CGFloat marginY = (rcH-sRow*sCircleSize)/(sRow+1);
    
    //
    for (int index = 0; index < sCirclesCount; index++)
    {
        //
        SYCircleView* circle = self.subviews[index];
        
        int aRow = index/sColumn;
        int aColumn = index%sColumn;
        CGFloat circleX = marginX + aColumn*(marginX+sCircleSize);
        CGFloat circleY = marginY + aRow*(marginY+sCircleSize);
        //
        circle.frame = CGRectMake(circleX, circleY, sCircleSize, sCircleSize);
        
    }
}

#pragma mark -
#pragma mark 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _currentPoint = CGPointMake(-1, -1);
    
    CGPoint pos = [self pointWithTouches:touches];
    
    SYCircleView* circle = [self circleWithPoint:pos];
    
    if (circle && circle.selected == NO)
    {
        circle.selected = YES;
        [self.selectedPoints addObject:circle];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [self pointWithTouches:touches];
    
    SYCircleView *circle = [self circleWithPoint:pos];
    
    if (circle && circle.selected == NO) {
        circle.selected = YES;
        [self.selectedPoints addObject:circle];
    } else {
        self.currentPoint = pos;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // notification
    if ([self.delegate respondsToSelector:@selector(touchLockView:didFinishPath:)])
    {
        NSMutableString* path = [NSMutableString string];
        
        for (int index = 0; index<_selectedPoints.count; index++)
        {
            SYCircleView* circle = self.selectedPoints[index];
            [path appendFormat:@"%d", (int)circle.tag];
        }
        [_delegate touchLockView:self didFinishPath:path];
    }
    // cancle
    [_selectedPoints makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    // clear
    [_selectedPoints removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch* touch = [touches anyObject];
    return [touch locationInView:touch.view];
}


- (SYCircleView *)circleWithPoint:(CGPoint)point
{
    for (SYCircleView* view in self.subviews)
    {
        CGRect rcOriginal=view.frame;
        CGRect rcNew = CGRectInset(rcOriginal, sCircleSize/4, sCircleSize/4);
        if (CGRectContainsPoint(rcNew, point))
        {
            return view;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark 绘图

- (void)drawRect:(CGRect)rect
{
    //
    if (_selectedPoints.count <= 0)
    {
        return;
    }
    //
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    
    
    for (int index=0; index<_selectedPoints.count;index++)
    {
        SYCircleView* circle = _selectedPoints[index];
        CGPoint center = circle.center;
        if (index == 0) {
            [path moveToPoint:center];
        } else {
            [path addLineToPoint:center];
        }
    }
    
    if (!CGPointEqualToPoint(_currentPoint, CGPointMake(-1, -1)))
    {
        [path addLineToPoint:_currentPoint];
    }
    
    // 绘图
    [sLineColor set];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinBevel;
    [path stroke];
}

- (void)dealloc
{
    NSLog(@"SYTouchLockView dealloc---->\n");
}

@end
