//
//  SYDocumentsViewController.m
//  SYExperence
//
//  Created by yuhang on 15/10/12.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYDocumentsViewController.h"
#import "SYBaseArrowFileItem.h"
#import "SYWebViewController.h"
@interface SYDocumentsViewController ()
{
    
}

@property (nonatomic, strong) NSArray* subDirs;

@end

@implementation SYDocumentsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _retrieveDirectories];
}


- (void)_retrieveDirectories
{
    //
    NSString* bundlePath = [NSBundle mainBundle].bundlePath;
    NSString* DocPath = [NSString stringWithFormat:@"%@/Documents", bundlePath];
    //
    _subDirs = [self subDirsInDirectory:DocPath];
    //
    
    [self addGroups];
    
}


- (void)addGroups
{
    for (NSString* dir in _subDirs)
    {
        SYBaseGroup* group = [[SYBaseGroup alloc] init];
        NSString* title = [dir lastPathComponent];
        group.headTitle = title;
        group.items = [NSMutableArray array];
        //
        NSArray* files = [self filesInDirectory:dir];
        __weak SYDocumentsViewController* weakVc = self;
        for (NSString* aFile in files)
        {
            SYBaseArrowFileItem* item = [SYBaseArrowFileItem itemWithTitle:[aFile lastPathComponent] iconStr:nil action:^{
                //
                SYWebViewController* vc = [[SYWebViewController alloc] init];
                vc.webviewUrl = [NSURL fileURLWithPath:aFile];
                [weakVc.navigationController pushViewController:vc animated:YES];
                
            }];
            item.filePath = aFile;
            [group.items addObject:item];
        }
        [self.data addObject:group];
    }
}



#pragma mark - 
#pragma mark 文件检索


- (NSArray *)filesInDirectory:(NSString *)path
{
    NSMutableArray* files = [NSMutableArray array];
    NSArray* contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString* content in contents)
    {
        NSString* contentPath = [NSString stringWithFormat:@"%@/%@", path, content];
        BOOL isDir = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:contentPath isDirectory:&isDir];
        if (!isDir)
        {
            [files addObject:contentPath];
        }
    }
    return files;
}

- (NSArray *)subDirsInDirectory:(NSString *)path
{
    NSMutableArray* dirs = [NSMutableArray array];
    NSArray* contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString* content in contents)
    {
        NSString* contentPath = [NSString stringWithFormat:@"%@/%@", path, content];
        BOOL isDir = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:contentPath isDirectory:&isDir];
        if (isDir)
        {
            [dirs addObject:contentPath];
        }
    }
    return dirs;
}
@end
