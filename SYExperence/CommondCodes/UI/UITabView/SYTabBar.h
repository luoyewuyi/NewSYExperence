//
//  SYTabBar.h
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>



/*
 * 简介
 * 1 为了显示和使用上能和原有的UITabBar一致，所以将SYTabBar添加到原有的UITabBar上面，同时使用UITabBar上UITabBarItem的参数初始化自己
 
 * 2 UITabBar和UITabBarItem的区别
 
    UITabBar* tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(40,0.0,240,30)];
    [mainView addSubview:tabBar];
 
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"排队人数" image:nil tag:0];
    UITabBarItem * tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"人均" image:nil tag:1];
    UITabBarItem * tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"距离" image:nil tag:2];
    UITabBarItem * tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"好评" image:nil tag:3];
    NSArray *tabBarItemArray = [[NSArray alloc] initWithObjects: tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4,nil];
    [tabBar setItems: tabBarItemArray];
 
 * 3 UITaBar 的子视图使用私有的子视图UITabBarButton（基类是UIControl）
 
 * 4 UITaBar 的子视图在ViewWillAppear才添加
 
 */
@class SYTabBar;

@protocol SYTabBarDelegate <NSObject>

@optional
- (void)tabBar:(SYTabBar *)tabBar didSelectedButtonFrom:(NSInteger)fromIndex to:(NSInteger)toIndex;

@end



@interface SYTabBar : UIView
{
    
}

@property (nonatomic, weak) id<SYTabBarDelegate> delegate;

/**
 * @brief   添加子控件
 * @param1  参数
 * @return
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem;
@end
