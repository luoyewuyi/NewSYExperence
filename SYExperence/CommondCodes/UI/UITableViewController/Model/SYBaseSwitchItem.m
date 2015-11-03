//
//  SYBaseSwitchItem.m
//  SYExperence
//
//  Created by yuhang on 15/9/15.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBaseSwitchItem.h"
#import "SYBaseSwitchCell.h"
@implementation SYBaseSwitchItem

+ (instancetype)itemWithTitle:(NSString *)title iconStr:(NSString *)iconStr action:(ItemAction)itemAction
{
    SYBaseSwitchItem* item = [[SYBaseSwitchItem alloc] init];
    
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
    SYBaseCell* cell = [SYBaseSwitchCell createCellWithTableView:tableView withItem:self];

    return cell;
}
@end
