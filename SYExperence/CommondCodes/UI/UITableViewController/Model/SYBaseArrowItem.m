//
//  SYBaseArrowItem.m
//  SYExperence
//
//  Created by yuhang on 15/9/15.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBaseArrowItem.h"
#import "SYBaseArrowCell.h"

@implementation SYBaseArrowItem


+ (instancetype)itemWithTitle:(NSString *)title iconStr:(NSString *)iconStr action:(ItemAction)itemAction
{
    SYBaseArrowItem* item = [[self alloc] init];
    
    item.title = title;
    item.iconStr = iconStr;
    item.itemAction = itemAction;
    
    return item;
}

/**
 * @brief   创建对应的Cell
 * @return
 */
- (SYBaseCell *)createRelevantCell:(UITableView *)tableView
{
    SYBaseCell* cell = [SYBaseArrowCell createCellWithTableView:tableView withItem:self];
    return cell;
}

- (void)dealloc
{
    NSLog(@"SYBaseArrowItem dealloc -----\n");
}
@end
