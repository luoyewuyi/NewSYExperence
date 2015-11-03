//
//  SYDownloadOperation.m
//  SYExperence
//
//  Created by yuhang on 15/10/12.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYDownloadOperation.h"

@implementation SYDownloadOperation

- (void)main
{
    @autoreleasepool
    {
        NSURL* url = [NSURL URLWithString:self.iconUrl];
        NSData* data = [NSData dataWithContentsOfURL:url];
        UIImage* image = [UIImage imageWithData:data];
        if ([self.delegate respondsToSelector:@selector(downloadOperation:finished:)])
        {
            // 回到主线程, 传递图片数据给代理对象
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate downloadOperation:self finished:image];
            });
        }
    }
    
}

@end
