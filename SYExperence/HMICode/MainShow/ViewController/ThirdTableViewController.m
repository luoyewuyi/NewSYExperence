//
//  ThirdTableViewController.m
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "ThirdTableViewController.h"
#import "SYDocumentsViewController.h"
@interface ThirdTableViewController ()

@end

@implementation ThirdTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGroup0];
}

- (void)addGroup0
{
    SYBaseGroup* group0 = [[SYBaseGroup alloc] init];
    //
    __weak UIViewController* weakVc = self;
    SYBaseArrowItem* item0 = [SYBaseArrowItem itemWithTitle:@"PPT" iconStr:nil action:^{
        //
        SYDocumentsViewController* vc = [[SYDocumentsViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    
    group0.items = (NSMutableArray*)@[item0];
    
    [self.data addObject:group0];
}


@end
