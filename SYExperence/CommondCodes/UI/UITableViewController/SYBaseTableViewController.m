//
//  SYBaseTableViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/15.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBaseTableViewController.h"
//
#import "SYBaseItem.h"
#import "SYBaseArrowItem.h"
#import "SYBaseSwitchItem.h"
#import "SYBaseLabelItem.h"
//
#import "SYBaseGroup.h"
//
#import "SYBaseCell.h"

#import "SYTableViewConstance.h"
@interface SYBaseTableViewController ()
{
    
}
@end

@implementation SYBaseTableViewController


#pragma mark -
#pragma mark 初始化，只是用Group

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 背景色
    //  backgroundView 的优先级 >  backgroundColor
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = SYTableviewBackgroundColor;//[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    // 分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark -
#pragma mark data
- (NSArray *)data
{
    if (_data == nil)
    {
        _data = [NSMutableArray array];
    }
    return _data;
}


#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SYBaseGroup* group = self.data[section];
    return group.items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SYBaseGroup* group = self.data[section];
    return group.headTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SYBaseGroup* group = self.data[section];
    return group.footTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger nowSection = indexPath.section;
    NSInteger nowRow = indexPath.row;
    
    SYBaseGroup*    group = self.data[nowSection];
    SYBaseItem*     item = group.items[nowRow];
    
    SYBaseCell*     cell = [item createRelevantCell:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger nowSection = indexPath.section;
    NSInteger nowRow = indexPath.row;
    
    SYBaseGroup*    group = self.data[nowSection];
    SYBaseItem*     item = group.items[nowRow];
    
    if (item.itemAction)
    {
        item.itemAction();
    }
}

- (void)dealloc
{
    NSLog(@"SYBaseTableViewController dealloc ---\n");
}
@end
