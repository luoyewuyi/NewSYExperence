//
//  SYStrongView.m
//  SYExperence
//
//  Created by yuhang on 15/9/1.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYStrongView.h"

@implementation SYStrongView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    if (self.dimBackground)
    CGContextRef context = UIGraphicsGetCurrentContext();
    {
        //Gradient colours
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,
                                0.1f,0.9f,0.4f,0.75f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace);
        //Gradient center
        [[UIColor redColor] set];
        CGPoint gradCenter= CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        //Gradient radius
        float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
        // 由中心向四周绘制渐变
        CGContextDrawRadialGradient (context, gradient, gradCenter,
                                     0, gradCenter, gradRadius,
                                     kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient);
    }
}


- (void)dealloc
{
    NSLog(@"SYStrong view dealloc \r");
}

//void CGContextDrawRadialGradient(
//                                 CGContextRef context,
//                                 CGGradientRef gradient, //先创造一个CGGradientRef,颜色是白,黑,location分别是0,1
//                                 CGPoint startCenter, // 白色的起点(中心圆点)
//                                 CGFloat startRadius, // 起点的半径,这个值多大,中心就是多大一块纯色的白圈
//                                 CGPoint endCenter, // 白色的终点(可以和起点一样,不一样的话就像探照灯一样从起点投影到这个终点,按照你的意图应该和startCenter一样
//                                 CGFloat endRadius, //终点的半径, 按照你的意图应该就是从中心到周边的长 
//                                 CGGradientDrawingOptions options //应该是 kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation 
//);

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
@end
