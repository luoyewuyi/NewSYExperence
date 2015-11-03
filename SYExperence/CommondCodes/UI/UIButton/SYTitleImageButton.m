//
//  SYTitleImageButton.m
//  SYExperence
//
//  Created by yuhang on 15/9/13.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYTitleImageButton.h"
#import <Availability.h>

@implementation SYTitleImageButton


/**
 * @brief   代码初始化
 * @return
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self _setup];
    }
    return self;
}

/**
 * @brief   文件初始化
 * @return
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self _setup];
    }
    return self;
}

/**
 * @brief   set up
 * @return
 */
- (void)_setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:18];
}

/**
 * @brief   返回文字区域
 * @param1
 * @return
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    
//    NSDictionary *dicAttributes = @{NSFontAttributeName:self.titleLabel.font};
    CGFloat titleW;
    if (SYIOS7)         // 运行时选项
    {
#ifdef __IPHONE_7_0     // 编译时选项
        titleW = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.width;
#else
        titleW = [self.titleLabel.text sizeWithFont:nil].width;
#endif
    } else {
        titleW = [self.titleLabel.text sizeWithFont:nil].width;
    }
    
    CGFloat titleH = contentRect.size.height;
    
    CGRect rcContent = CGRectMake(titleX, titleY, titleW, titleH);
    
    return rcContent;
}

@end
