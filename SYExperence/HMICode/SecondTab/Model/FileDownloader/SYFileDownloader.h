//
//  SYFileDownloader.h
//  SYExperence
//
//  Created by yuhang on 15/10/25.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYFileDownloader : NSObject
{
    BOOL _downloading;
}


@property (nonatomic, strong)   NSString* url;

@property (nonatomic, strong)   NSString* destPath;

@property (nonatomic, readonly, getter=isDownloading)   BOOL downloading;

@property (nonatomic, copy)     void(^progressHandler)(double progress);

- (void)start;


- (void)pause;

@end
