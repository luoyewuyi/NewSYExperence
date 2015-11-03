//
//  SYBaseItem.h
//  SYExperence
//
//  Created by yuhang on 15/9/15.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SYBaseCell.h"


@class SYBaseCell;
typedef void (^ItemAction)(void);

@interface SYBaseItem : NSObject
{
    
}

/**
 * 标题;
 */
@property (nonatomic, copy) NSString* title;

/**
 * 图片;
 */
@property (nonatomic, copy) NSString* iconStr;

/**
 * 响应;
 */
@property (nonatomic, copy) ItemAction itemAction;


/**
 * @brief   初始化
 * @param1  title
 * @param2  iconStr
 * @return  return
 */
+ (instancetype)itemWithTitle:(NSString *)title iconStr:(NSString *)iconStr action:(ItemAction)itemAction;

/**
 * @brief   创建对应的Cell
 * @return
 */
- (SYBaseCell *)createRelevantCell:(UITableView *)tableView;

@end
