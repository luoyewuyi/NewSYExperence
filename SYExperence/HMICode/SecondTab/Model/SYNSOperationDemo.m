//
//  SYNSOperationDemo.m
//  SYExperence
//
//  Created by yuhang on 15/10/12.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYNSOperationDemo.h"

@implementation SYNSOperationDemo


/*
 * @brief test
 * return
 */

- (void)demoCode
{
    //
    [self _invocationOperation];
    //
    [self _blockOperation];
    //
    [self _operationQueue];
}

- (void)_operationQueue
{
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        //
        NSLog(@"_operation->>queue\n");
    }];
}

- (void)_blockOperation
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //
        NSLog(@"_operation->>blockOperation\n");
    }];
    [operation start];
}

- (void)_invocationOperation
{
    NSInvocationOperation* invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(_operationCall) object:nil];
    [invocation start];
}

- (void)_operationCall
{
    NSLog(@"_operationCall->>invocation\n");
}

@end
