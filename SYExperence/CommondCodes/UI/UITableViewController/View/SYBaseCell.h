//
//  SYBaseCell.h
//  SYExperence
//
//  Created by yuhang on 15/9/15.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYBaseItem.h"


@class SYBaseItem;

@interface SYBaseCell : UITableViewCell
{
    
}


/**
 * @brief   初始化
 * @return
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView withItem:(SYBaseItem *)item;

@end
