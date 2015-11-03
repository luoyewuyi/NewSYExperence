//
//  SecondTableViewController.m
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SecondTableViewController.h"
#import "SYSingleTool.h"


//
#import "SYImageDownloadTableViewController.h"
#import "SYNetWorkViewController.h"
//
@interface SecondTableViewController ()

@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGroup0];
    [self addGroup1];
}

- (void)addGroup0
{
    __weak SecondTableViewController* weakVc = self;
    
    SYBaseGroup* group0 = [[SYBaseGroup alloc] init];
    SYBaseArrowItem* item0 = [SYBaseArrowItem itemWithTitle:@"单例" iconStr:nil action:^{
        //
        [SYSingleTool sharedDemoInstance];
    }];
    SYBaseArrowItem* item1 = [SYBaseArrowItem itemWithTitle:@"图片异步加载" iconStr:nil action:^{
        //
        SYImageDownloadTableViewController* vc = [[SYImageDownloadTableViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    
    SYBaseArrowItem* item2 = [SYBaseArrowItem itemWithTitle:@"网络服务器功能测试" iconStr:nil action:^{
        //
        UIViewController* vc = [[SYNetWorkViewController alloc] initWithNibName:@"SYNetWorkViewController" bundle:nil];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    
    SYBaseArrowItem* item3 = [self viewControllerItemWith:@"SYRegularExpressionDemo" title:@"正则表达"];
    SYBaseArrowItem* item4 = [self viewControllerItemWith:@"SYBDMainMapViewController" title:@"百度地图"];
    
    group0.items = (NSMutableArray *)@[item0, item1,item2, item3, item4];
    //
    [self.data addObject:group0];
}

- (void)addGroup1
{
    
}

- (SYBaseArrowItem *)viewControllerItemWith:(NSString *)clsssName title:(NSString *)title
{
    __weak SecondTableViewController* weakVc = self;
    Class vcClass = NSClassFromString(clsssName);
    SYBaseArrowItem* item = [SYBaseArrowItem itemWithTitle:title iconStr:nil action:^{
        //
        UIViewController* vc = [[vcClass alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    return item;
}
@end
