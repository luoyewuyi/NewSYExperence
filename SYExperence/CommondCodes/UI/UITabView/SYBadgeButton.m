//
//  SYBadgeButton.m
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBadgeButton.h"

@implementation SYBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.hidden = YES;
        
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage SYResizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue)
    {
        self.hidden = NO;
        // 文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 控件布局
        // 只有一个文字时，使用图片大小，否则根据文字调整控件大小
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1)
        {
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
             badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    }
    else
    {
        self.hidden = YES;
    }
}

@end
