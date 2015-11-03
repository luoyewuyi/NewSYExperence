//
//  SYBaseSwitchCell.m
//  SYExperence
//
//  Created by yuhang on 15/9/16.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBaseSwitchCell.h"

@interface SYBaseSwitchCell ()

@property (nonatomic, strong)  UISwitch* subSwitch;

@end


@implementation SYBaseSwitchCell



- (UISwitch *)subSwitch
{
    if (_subSwitch == nil)
    {
        _subSwitch = [[UISwitch alloc] init];
    }
    return _subSwitch;
}
/**
 * @brief   初始化
 * @return
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView withItem:(SYBaseItem *)item
{
    static NSString* reuseIdentifier = @"SYBaseCell";
    
    SYBaseSwitchCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil)
    {
        cell = [[SYBaseSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setCurrentItem:item];
    
    return cell;
}


/**
 * @brief
 * @return
 */
- (void)setCurrentItem:(SYBaseItem *)item
{
    self.textLabel.text = item.title;
    self.imageView.image = [UIImage SYImageWithName:item.iconStr];
    
    if ([item isKindOfClass:NSClassFromString(@"SYBaseSwitchItem")])
    {
        //
        self.accessoryView = self.subSwitch;
    }else{
        self.accessoryView = nil;
    }
}

@end
