//
//  SYCustomLayer.m
//  SYExperence
//
//  Created by yuhang on 15/9/25.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYCustomLayer.h"

@implementation SYCustomLayer

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextAddRect(ctx, CGRectMake(0, 0, 50, 50));
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextFillPath(ctx);
}

@end
