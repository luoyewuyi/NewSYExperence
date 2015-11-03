//
//  SYSingleTool.m
//  SYExperence
//
//  Created by yuhang on 15/10/10.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYSingleTool.h"

@implementation SYSingleTool


SYSharedInstance_m(Demo);


- (id)init
{
    if (self = [super init])
    {
        //
        NSLog(@"Single Tool init\n");
    }
    return self;
}


#if !__has_feature(objc_arc)
- (void)release
{
    
}

- (void)retain
{
    
}
#endif

@end
