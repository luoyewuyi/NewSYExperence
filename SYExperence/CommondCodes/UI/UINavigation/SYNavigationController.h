//
//  SYNavigationController.h
//  SYExperence
//
//  Created by yuhang on 15/8/30.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 // 设置背景
 UINavigationBar* navigationBar = [UINavigationBar appearance];
 [navigationBar setBackgroundImage:[UIImage imageNamed:@"64p for ios7"] forBarMetrics:UIBarMetricsDefault];
 
 // 设置字体
 UINavigationBar* navigationBar = [UINavigationBar appearance];
 NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
 attributes[UITextAttributeTextColor] = [UIColor redColor];
 attributes[UITextAttributeFont] = [UIFont systemFontOfSize:20];
 [navigationBar setTitleTextAttributes:attributes];
 
 // 在push方法中，设置隐藏底栏
 */

/*
 * 自定义UINavigationBar
 UINavigationBar *bar = [UINavigationBar alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44);
 //定义一个UINavigationBar。
 UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"hellows"];
 //定义一个UINavigationItem。
 UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"Right" style:UIBarButtonItemStyleBordered target:self action:@selector(right)];
 //定义一个UIBarButtonItem右按钮。
 UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"Left" style:UIBarButtonItemStyleBordered target:self action:@selector(left)];
 //定义一个UIBarButtonItem左按钮
 item.rightBarButtonItem = right;
 item.leftBarButtonItem = left;
 //将两个按钮添加到Item中
 [bar pushNavigationItem:item animated:NO];
 //将Item添加到bar中
 NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:UITextAttributeTextColor];
 bar.titleTextAttributes = dic;
 //设置bar的title的字体颜色。
 */

/*
2. PushView 的动画修改

CATransition *transition = [CATransition animation];
transition.duration = 1;
transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
transition.type = kCATransitionPush;
transition.subtype = kCATransitionFromTop;
transition.delegate = self;
[self.navigationController.view.layer addAnimation:transition forKey:nil];
 */
@interface SYNavigationController : UINavigationController

@end
