//
//  SYWheelButton.m
//  SYExperence
//
//  Created by yuhang on 15/9/26.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYWheelButton.h"

@implementation SYWheelButton

/*
 
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width-imageW)*0.5;
    CGFloat imageY = 20;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}


/*
 重载，按下时没有状态
 */
- (void)setHighlighted:(BOOL)highlighted
{
    
}


@end
