//
//  SYFileMultiDownloader.m
//  SYExperence
//
//  Created by yuhang on 15/10/25.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import "SYFileMultiDownloader.h"
#import "SYFileSingleDownloader.h"

#define HMMaxDownloadCount 4

@interface SYFileMultiDownloader ()
{
    
}

@property (nonatomic, strong) NSMutableArray *singleDownloaders;

@property (nonatomic, assign) long long totalLength;

@end

@implementation SYFileMultiDownloader

- (void)getFilesize
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    request.HTTPMethod = @"HEAD";
    
    NSURLResponse *response = nil;
#warning 这里要用异步请求
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    self.totalLength = response.expectedContentLength;
}

- (NSMutableArray *)singleDownloaders
{
    if (!_singleDownloaders) {
        _singleDownloaders = [NSMutableArray array];
        
        // 获得文件大小
        [self getFilesize];
        
        // 每条路径的下载量
        long long size = 0;
        if (self.totalLength % HMMaxDownloadCount == 0) {
            size = self.totalLength / HMMaxDownloadCount;
        } else {
            size = self.totalLength / HMMaxDownloadCount + 1;
        }
        
        // 创建N个下载器
        for (int i = 0; i<HMMaxDownloadCount; i++) {
            SYFileSingleDownloader *singleDownloader = [[SYFileSingleDownloader alloc] init];
            singleDownloader.url = self.url;
            singleDownloader.destPath = self.destPath;
            singleDownloader.begin = i * size;
            singleDownloader.end = singleDownloader.begin + size - 1;
            singleDownloader.progressHandler = ^(double progress){
                NSLog(@"%d --- %f", i, progress);
            };
            [_singleDownloaders addObject:singleDownloader];
        }
        
        // 创建一个跟服务器文件等大小的临时文件
        [[NSFileManager defaultManager] createFileAtPath:self.destPath contents:nil attributes:nil];
        
        // 让self.destPath文件的长度是self.totalLengt
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:self.destPath];
        [handle truncateFileAtOffset:self.totalLength];
    }
    return _singleDownloaders;
}

/**
 * 开始(恢复)下载
 */
- (void)start
{
    [self.singleDownloaders makeObjectsPerformSelector:@selector(start)];
    
    _downloading = YES;
}

/**
 * 暂停下载
 */
- (void)pause
{
    [self.singleDownloaders makeObjectsPerformSelector:@selector(pause)];
    _downloading = NO;
}
@end
