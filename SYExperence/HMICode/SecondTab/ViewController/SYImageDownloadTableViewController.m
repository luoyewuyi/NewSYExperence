//
//  SYImageDownloadTableViewController.m
//  SYExperence
//
//  Created by yuhang on 15/10/12.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//
/*
 * 掌握的知识点
 1 变量采用延时加载
 2 自定义NSOperation， 线程，main函数实现
 3 使用字典来维护对应关系，字典保存下载队列，字典保存已经下载的图片
 4 理清下载图片的思路
 */



#import "SYImageDownloadTableViewController.h"
#import "SYDownloadOperation.h"
#import "SYAppInfo.h"

#import <SDWebImage/UIImageView+WebCache.h>
@interface SYImageDownloadTableViewController ()<SYDownloadOperationDelegate>
{
    
}

@property (nonatomic, strong)   NSArray*    apps;

@property (nonatomic, strong)   NSOperationQueue* operaionQueue;

@property (nonatomic, strong)   NSMutableDictionary* images;

@property (nonatomic, strong)   NSMutableDictionary* operations;

@end

@implementation SYImageDownloadTableViewController

#pragma mark -
#pragma mark 延时加载
- (NSArray *)apps
{
    if (_apps == nil)
    {
        NSArray* dicArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        NSMutableArray *appArray = [NSMutableArray array];
        for (NSDictionary* dic in dicArray) {
            SYAppInfo* appInfo = [SYAppInfo appInfoWithDict:dic];
            [appArray addObject:appInfo];
        }
        _apps = appArray;
    }
    return _apps;
}

- (NSOperationQueue *)operaionQueue
{
    if (!_operaionQueue) {
        _operaionQueue = [[NSOperationQueue alloc] init];
    }
    return _operaionQueue;
}

- (NSMutableDictionary *)images
{
    if (!_images) {
        _images = [[NSMutableDictionary alloc] init];
    }
    return _images;
}

- (NSMutableDictionary *)operations
{
    if (!_operations)
    {
        _operations = [[NSMutableDictionary alloc] init];
    }
    return _operations;
}


#pragma mark -
#pragma mark 视图控制器

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //
    SYAppInfo* appInfo = self.apps[indexPath.row];
    
    cell.textLabel.text =appInfo.name;
    cell.detailTextLabel.text = appInfo.download;
    
    /*
     * 自定义的方法
     */
//    UIImage* iconImage = _images[appInfo.icon];
//    if (iconImage) {
//        cell.imageView.image = iconImage;
//    } else {
//        cell.imageView.image = [UIImage imageNamed:@"MoreUpdate"];
//        SYDownloadOperation* operation = _operations[appInfo.icon];
//        if (!operation)
//        {
//            operation = [[SYDownloadOperation alloc] init];
//            operation.iconUrl = appInfo.icon;
//            operation.indexPath = indexPath;
//            operation.delegate = self;
//            [self.operaionQueue addOperation:operation];
//            
//            self.operations[appInfo.icon] = operation;
//        }
//    }
    /*
     * 使用第三方代码，SDWebImage方便易用
     */
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:appInfo.icon] placeholderImage:[UIImage imageNamed:@"MoreUpdate"]];
    return cell;
}

#pragma mark -
#pragma mark delegate
- (void)downloadOperation:(SYDownloadOperation *)operation finished:(UIImage *)image
{
    [self.operations removeObjectForKey:operation.iconUrl];
    if (image)
    {
        //
        self.images[operation.iconUrl] = image;
        
        [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationRight];
        //
        
    }
}

#pragma mark -
#pragma mark scrollview

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.operaionQueue setSuspended:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.operaionQueue setSuspended:NO];
}
@end
