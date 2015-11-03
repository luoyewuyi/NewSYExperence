//
//  SYCircleView.m
//  SYExperence
//
//  Created by yuhang on 15/9/24.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYCircleView.h"

@implementation SYCircleView

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
    [self setBackgroundImage:[UIImage SYImageWithName:@"gesture_node_normal.png"] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[UIImage SYImageWithName:@"gesture_node_highlighted.png"] forState:UIControlStateSelected];
    
    self.userInteractionEnabled = NO;
}

@end
