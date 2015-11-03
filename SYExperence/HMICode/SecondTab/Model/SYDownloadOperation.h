//
//  SYDownloadOperation.h
//  SYExperence
//
//  Created by yuhang on 15/10/12.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYDownloadOperation;

@protocol SYDownloadOperationDelegate <NSObject>

@optional

- (void)downloadOperation:(SYDownloadOperation *)operation finished:(UIImage *)image;

@end


@interface SYDownloadOperation : NSOperation
{
    
}

@property (nonatomic, strong)   NSString* iconUrl;

@property (nonatomic, strong)   NSIndexPath* indexPath;

@property (nonatomic, weak)     id<SYDownloadOperationDelegate> delegate;

@end
