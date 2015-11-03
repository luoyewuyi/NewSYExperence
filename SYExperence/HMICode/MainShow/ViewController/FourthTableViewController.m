//
//  FourthTableViewController.m
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "FourthTableViewController.h"
#import "SYCommonToolInfo.h"

@interface FourthTableViewController ()
{
    
}

@property (nonatomic, strong)   NSArray* tools;

@end

@implementation FourthTableViewController

- (NSArray *)tools
{
    if (!_tools) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"CommonTools.plist" ofType:nil];
        NSArray* dics = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray* tempTools = [NSMutableArray array];
        for (NSDictionary* dic in dics)
        {
            //
            SYCommonToolInfo* info = [[SYCommonToolInfo alloc] initWithDictionary:dic error:nil];
            //
            [tempTools addObject:info];
        }
        _tools = tempTools;
    }
    return _tools;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGroup0];
}

- (void)addGroup0
{
    NSMutableArray* items = [NSMutableArray array];
    for (SYCommonToolInfo* tool in self.tools)
    {
        SYBaseArrowItem* item = [SYBaseArrowItem itemWithTitle:tool.name iconStr:nil action:^{
            //
            
        }];
        item.subTitle = tool.brief;
        [items addObject:item];
    }
    SYBaseGroup* group0 = [[SYBaseGroup alloc] init];
    group0.items = items;
    //
    [self.data addObject:group0];
}

@end
