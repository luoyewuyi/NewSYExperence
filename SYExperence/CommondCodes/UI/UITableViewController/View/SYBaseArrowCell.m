//
//  SYBaseArrowCell.m
//  SYExperence
//
//  Created by yuhang on 15/9/16.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBaseArrowCell.h"
#import "SYBaseArrowItem.h"
@interface SYBaseArrowCell ()
{
    
}

@property (nonatomic, strong) UIImageView* arrowView;


@end


@implementation SYBaseArrowCell

- (UIImageView *)arrowView
{
    if (_arrowView == nil)
    {
        UIImage* image = [UIImage SYImageWithName:@"common_icon_arrow"];
        _arrowView = [[UIImageView alloc] initWithImage:image];
    }
    return _arrowView;
}

/**
 * @brief   初始化
 * @return
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView withItem:(SYBaseItem *)item
{
    static NSString* reuseIdentifier = @"SYBaseCell";
    
    SYBaseArrowCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil)
    {
        cell = [[SYBaseArrowCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
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
    
    if ([item isKindOfClass:NSClassFromString(@"SYBaseArrowItem")])
    {
        //
        SYBaseArrowItem* arrowItem = (SYBaseArrowItem*)item;
        self.accessoryView = self.arrowView;
        if (arrowItem.subTitle) {
            self.detailTextLabel.text = arrowItem.subTitle;
        }
    }else
    {
        self.accessoryView = nil;
    }
}

@end
