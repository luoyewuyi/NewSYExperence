//
//  SYNavigationController.m
//  SYExperence
//
//  Created by yuhang on 15/8/30.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYNavigationController.h"

@interface SYNavigationController ()

@end

@implementation SYNavigationController

/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
//    // 1 设置导航栏主题
//    UINavigationBar* naviBar = [UINavigationBar appearance];
//    // 设置背景图片
//    NSString *bgName = nil;
//    if (SYIOS7) {
//        bgName = @"NavBar64";
//    } else {
//        bgName = @"NavBar";
//    }
//    [naviBar setBackgroundImage:[UIImage imageNamed:bgName] forBarMetrics:UIBarMetricsDefault];
//    
//    // 2 设置标题文字颜色
//    NSMutableDictionary* naviAttrs = [NSMutableDictionary dictionary];
//    naviAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    naviAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
//    [naviBar setTitleTextAttributes:naviAttrs];
//    
//    // 3 设置BarButtonItem的主题
//    UIBarButtonItem* item = [UIBarButtonItem appearance];
//    NSMutableDictionary* itemAttrs = [NSMutableDictionary dictionary];
//    itemAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
//    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置背景
    if (!SYIOS7) {
        [item setBackgroundImage:[UIImage SYImageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage SYImageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage SYImageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    // IOS7 设置前景图颜色，IOS6 设置背景颜色
    [item setTintColor:[UIColor redColor]];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = SYIOS7 ? [UIColor orangeColor] : [UIColor grayColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:SYIOS7 ? 14 : 12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

/**
 *  设置导航栏主题,ios7(44+20),ios6(44)
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景
    if (!SYIOS7)
    {
        [navBar setBackgroundImage:[UIImage SYImageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 设置当push的是第二个的时候，才隐藏bottomBar
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
