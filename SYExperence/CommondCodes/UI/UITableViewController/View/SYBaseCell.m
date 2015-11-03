//
//  SYBaseCell.m
//  SYExperence
//
//  Created by yuhang on 15/9/15.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBaseCell.h"

#import "SYTableViewConstance.h"

@interface SYBaseCell ()
{
    
}

@property (nonatomic, weak) UIView *divider;

@end


@implementation SYBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1 初始化北京
        [self setupBg];
        // 2 初始化子控件
        [self setupSubviews];
        // 3 初始化分割线
        [self setupDivider];
    }
    return self;
}


#pragma mark -
#pragma mark
- (void)setupBg
{
    // 设置普通背景
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = SYCellColor;//[UIColor whiteColor];
    self.backgroundView = bg;
    
    // 设置选中时的背景
    UIView *selectedBg = [[UIView alloc] init];
    selectedBg.backgroundColor = SYCellSelectedColor;
    self.selectedBackgroundView = selectedBg;
}

- (void)setupSubviews
{
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)setupDivider
{
    if (SYIOS7)
    {
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = SYCellSeparatorLineColor;
        divider.alpha = 0.2;
        [self.contentView addSubview:divider];
        self.divider = divider;
    }
}


/**
 *  设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置分割线的frame
    CGFloat dividerH = 1;
    CGFloat dividerW = self.frame.size.width;
    CGFloat dividerX = 0;
    CGFloat dividerY = self.contentView.frame.size.height - dividerH;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

@end
