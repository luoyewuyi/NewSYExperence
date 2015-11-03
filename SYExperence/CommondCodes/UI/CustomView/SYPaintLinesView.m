//
//  SYPaintLinesView.m
//  SYExperence
//
//  Created by yuhang on 15/9/23.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYPaintLinesView.h"
#import "UIImage+SYImageName.h"
#import <UIKit/UIImagePickerController.h>
#import "MBProgressHUD+SY.h"
@interface SYPaintLinesView ()
{
    
}

@property (nonatomic, strong) NSMutableArray* totalPoints;

@end




@implementation SYPaintLinesView

/**
 * @brief   清空
 * @return
 */
- (void)clearUp
{
    [_totalPoints removeAllObjects];
    [self _rePaint];
}

/*
 * @brief   回退
 * return
 */
- (void)unDo
{
    [_totalPoints removeLastObject];
    [self _rePaint];
}

/*
 * @brief   保存到相册
 * return
 */
- (void)saveToPhoneAlbum
{
    UIImage* snapshot = [UIImage SYSnapshotOfView:self];
    //
    UIImageWriteToSavedPhotosAlbum(snapshot, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 保存图片操作之后就会调用
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) { // 保存失败
        [MBProgressHUD showError:@"保存失败"];
    } else { // 保存成功
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

#pragma mark -
#pragma mark private

- (NSMutableArray *)totalPoints
{
    if (_totalPoints == nil)
    {
        _totalPoints = [NSMutableArray array];
    }
    return _totalPoints;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //
    NSMutableArray* newLines = [NSMutableArray array];
    [newLines addObject:[NSValue valueWithCGPoint:point]];
    
    [self.totalPoints addObject:newLines];
    [self _rePaint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //
    NSMutableArray* newLines = [_totalPoints lastObject];
    [newLines addObject:[NSValue valueWithCGPoint:point]];
    [self _rePaint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //
    NSMutableArray* newLines = [_totalPoints lastObject];
    [newLines addObject:[NSValue valueWithCGPoint:point]];
    //
    [self _rePaint];
}

- (void)drawRect:(CGRect)rect
{
    /*
     * 方法一： 使用C语言
     */
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //
//    CGContextSetLineWidth(context, 5);
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    //
//    for (NSArray* points in _totalPoints)
//    {
//        for (NSInteger i=0; i<points.count; i++)
//        {
//            NSValue* value = points[i];
//            CGPoint point = [value CGPointValue];
//            if (i==0)
//            {
//                CGContextMoveToPoint(context, point.x, point.y);
//            }else{
//                CGContextAddLineToPoint(context, point.x, point.y);
//            }
//        }
//        CGContextStrokePath(context);
//    }
    /*
     * 方法二：使用
     */
    [[UIColor redColor] set];
    for (NSArray* points in _totalPoints)
    {
        UIBezierPath* path = [UIBezierPath bezierPath];
        for (NSInteger i=0; i<points.count; i++)
        {
            NSValue* value = points[i];
            CGPoint point = [value CGPointValue];
            
            if (i==0) {
                [path moveToPoint:point];
            }else{
                [path addLineToPoint:point];
            }
        }
        path.lineWidth = 10;
        [path stroke];
    }
}

- (void)_rePaint
{
    //
    [self setNeedsDisplay];
}
@end
