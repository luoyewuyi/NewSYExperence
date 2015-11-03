//
//  SYAppItemCell.m
//  SYExperence
//
//  Created by yuhang on 15/9/21.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYAppItemCell.h"
#import "SYAppItem.h"

@interface SYAppItemCell ()
{
    
}

@property (nonatomic, strong)   UIImageView* iconView;

@property (nonatomic, strong)   UILabel*     titleView;

@end


@implementation SYAppItemCell

#pragma mark -
#pragma mark view
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        
        _titleView = [[UILabel alloc] init];
        [self addSubview:_titleView];
        _titleView.textAlignment = NSTextAlignmentCenter;
    }
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)layoutSubviews
{
    CGRect rcSuper = self.frame;
    
    CGFloat labelHeight = 20;
    //
    CGSize imageSize = _iconView.image.size;
    //
    CGFloat imageW = imageSize.width;
    CGFloat imageH = imageSize.height;
    
    CGFloat imageX = (rcSuper.size.width-imageW)/2;
    CGFloat imageY = (rcSuper.size.height-imageH - labelHeight)/2;
    
    
    [_iconView setFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    //
    CGFloat labelX = 0;
    CGFloat labelY = imageY + imageH;
    CGFloat labelW = rcSuper.size.width;
    CGFloat labelH = labelHeight;
    [_titleView setFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    
}

#pragma mark -
#pragma mark data
- (void)setItem:(SYAppItem *)item
{
    _item = item;
    _iconView.image = [UIImage SYImageWithName:item.icon];
    _titleView.text = item.title;
}



@end
